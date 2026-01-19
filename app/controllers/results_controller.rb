class ResultsController < ApplicationController
  include AssessmentScoring

  before_action :load_assessment

  def show
    redirect_to invite_path(params[:token]) unless @assessment
    @summary = calculate_summary(@assessment)
    @assessment.status = "completed"
    update_progress(@assessment, @assessment.scores.length, @assessment.scores.length)
    update_last_step(@assessment, "results")
    @assessment.save

  end

  private

  def load_assessment
    @assessment = Assessment.find_by(invite_token: params[:token])
  end
end
