module AssessmentsHelper
  def invite_link(assessment)
    invite_url(token: assessment.invite_token)
  end

  def assessment_progress_label(assessment)
    "Progress: #{assessment.progress_percent}%"
  end

  def assessment_score_label(assessment)
    summary = ScoreCalculator.calculate(
      BenchmarkData.pillars,
      assessment.selections,
      assessment.scores
    )
    "Score: #{format("%.0f", summary[:composite_score])}"
  end
end
