module AssessmentScoring
  extend ActiveSupport::Concern

  def calculate_summary(assessment)
    ScoreCalculator.calculate(
      BenchmarkData.pillars,
      assessment.selections,
      assessment.scores
    )
  end

  def update_progress(assessment, completed_metrics, total_metrics)
    percent = total_metrics.positive? ? ((completed_metrics.to_f / total_metrics) * 100).round : 0
    assessment.progress_data = {
      "completed_metrics" => completed_metrics,
      "total_metrics" => total_metrics,
      "percent" => [ percent, 100 ].min,
      "updated_at" => Time.current.iso8601
    }
  end

  def update_last_step(assessment, step)
    progress = assessment.progress_data.presence || {}
    progress["last_step"] = step
    progress["updated_at"] = Time.current.iso8601
    assessment.progress_data = progress
  end

  def resume_path_for(assessment)
    step = assessment.progress_data&.fetch("last_step", nil)
    return invite_path(assessment.invite_token) if step.blank?

    case step
    when "company"
      company_path(token: assessment.invite_token)
    when "qualify"
      qualify_path(token: assessment.invite_token)
    when "modules"
      modules_path(token: assessment.invite_token)
    when "results"
      results_path(token: assessment.invite_token)
    when /^assessment:/
      next_entry = next_incomplete_metric(assessment)
      return results_path(token: assessment.invite_token) unless next_entry

      assessment_step_path(
        token: assessment.invite_token,
        pillar_id: next_entry[:pillar][:id],
        metric_id: next_entry[:metric][:id]
      )
    else
      invite_path(assessment.invite_token)
    end
  end

  def next_incomplete_metric(assessment)
    selected_metrics = BenchmarkData.selected_metrics(assessment.selections)
    return if selected_metrics.empty?

    completed_ids = assessment.scores
      .select { |score| score["completed"] }
      .map { |score| score["metric_id"] }

    selected_metrics.find { |entry| !completed_ids.include?(entry[:metric][:id]) }
  end
end
