class ModulesController < ApplicationController
  include AssessmentScoring

  before_action :load_assessment

  def edit
    redirect_to invite_path(params[:token]) unless @assessment&.active?
    @pillars = BenchmarkData.pillars
  end

  def update
    unless @assessment&.active?
      redirect_to invite_path(params[:token])
      return
    end

    selected_pillar_ids = params.fetch(:pillars, []).map(&:to_s)
    @assessment.selections = BenchmarkData.build_selections(selected_pillar_ids)

    if next_metric
      update_last_step(@assessment, "assessment:#{next_metric[:pillar][:id]}:#{next_metric[:metric][:id]}")
    else
      update_last_step(@assessment, "assessment:none:none")
    end

    if @assessment.save
      if next_metric
        redirect_to assessment_step_path(
          token: @assessment.invite_token,
          pillar_id: next_metric[:pillar][:id],
          metric_id: next_metric[:metric][:id]
        )
      else
        redirect_to assessment_step_path(
          token: @assessment.invite_token,
          pillar_id: "none",
          metric_id: "none"
        )
      end
    else
      flash.now[:alert] = @assessment.errors.full_messages.to_sentence
      @pillars = BenchmarkData.pillars
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def load_assessment
    @assessment = Assessment.find_by(invite_token: params[:token])
  end

  def next_metric
    BenchmarkData.selected_metrics(@assessment.selections).first
  end
end
