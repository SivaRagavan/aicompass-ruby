module AssessmentsHelper
  def invite_link(assessment)
    invite_url(token: assessment.invite_token)
  end

  def assessment_progress_label(assessment)
    "Progress: #{assessment.progress_percent}%"
  end
end
