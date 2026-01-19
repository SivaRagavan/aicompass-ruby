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
      "percent" => [percent, 100].min,
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
      _, pillar_id, metric_id = step.split(":", 3)
      assessment_step_path(token: assessment.invite_token, pillar_id: pillar_id, metric_id: metric_id)
    else
      invite_path(assessment.invite_token)
    end
  end
end
