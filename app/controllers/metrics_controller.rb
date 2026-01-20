class MetricsController < ApplicationController
  include AssessmentScoring

  before_action :load_assessment
  helper_method :selected_metric_index

  def show
    redirect_to invite_path(params[:token]) unless @assessment&.active?
    @selected_metrics = BenchmarkData.selected_metrics(@assessment.selections)
    @current_metric = current_metric_entry

    return if @current_metric

    flash[:alert] = "Select at least one module to begin scoring."
    redirect_to modules_path(token: @assessment.invite_token)
  end

  def update
    unless @assessment&.active?
      redirect_to invite_path(params[:token])
      return
    end

    @selected_metrics = BenchmarkData.selected_metrics(@assessment.selections)
    metric_entry = current_metric_entry
    @current_metric = metric_entry
    unless metric_entry
      redirect_to modules_path(token: @assessment.invite_token)
      return
    end

    responses = metric_response_values(metric_entry)
    @assessment.scores = upsert_score(@assessment.scores, metric_entry, responses)
    mark_completed(metric_entry[:metric][:id])
    update_progress(@assessment, completed_metric_count, @selected_metrics.length)
    update_last_step(@assessment, "assessment:#{metric_entry[:pillar][:id]}:#{metric_entry[:metric][:id]}")

    if @assessment.save
      redirect_to next_metric_path
    else

      flash.now[:alert] = @assessment.errors.full_messages.to_sentence
      @current_metric = metric_entry
      render :show, status: :unprocessable_entity
    end
  end

  private

  def load_assessment
    @assessment = Assessment.find_by(invite_token: params[:token])
  end

  def current_metric_entry
    @selected_metrics.find do |entry|
      entry[:pillar][:id] == params[:pillar_id] && entry[:metric][:id] == params[:metric_id]
    end || @selected_metrics.first
  end

  def selected_metric_index
    @selected_metrics.index(@current_metric) || 0
  end

  def upsert_score(scores, metric_entry, responses)
    scores = scores.to_a.map(&:dup)
    metric_id = metric_entry[:metric][:id]
    existing = scores.find { |item| item["metric_id"] == metric_id }
    average = responses.sum.to_f / responses.length

    if existing
      existing["responses"] = responses
      existing["score"] = average
    else
      scores << {
        "metric_id" => metric_id,
        "pillar_id" => metric_entry[:pillar][:id],
        "responses" => responses,
        "score" => average,
        "completed" => false
      }
    end

    scores
  end

  def mark_completed(metric_id)
    @assessment.scores = @assessment.scores.map do |score|
      if score["metric_id"] == metric_id
        score.merge("completed" => true)
      else
        score
      end
    end
  end

  def metric_response_values(metric_entry)
    responses = params.fetch(:responses, {}).to_unsafe_h
    question_count = metric_entry[:metric][:questions].length
    (0...question_count).map do |index|
      responses[index.to_s].to_i.clamp(0, 5)
    end
  end

  def completed_metric_count
    @assessment.scores.count { |score| score["completed"] }
  end

  def next_metric_path
    return results_path(token: @assessment.invite_token) if last_metric?

    next_entry = @selected_metrics[current_metric_index + 1]
    assessment_step_path(
      token: @assessment.invite_token,
      pillar_id: next_entry[:pillar][:id],
      metric_id: next_entry[:metric][:id]
    )
  end

  def last_metric?
    current_metric_index >= @selected_metrics.length - 1
  end

  def current_metric_index
    @selected_metrics.index(@current_metric) || 0
  end
end
