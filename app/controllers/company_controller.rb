class CompanyController < ApplicationController
  include AssessmentScoring

  before_action :load_assessment

  def edit
    redirect_to invite_path(params[:token]) unless @assessment&.active?
  end

  def update
    unless @assessment&.active?
      redirect_to invite_path(params[:token])
      return
    end

    @assessment.company_name = params[:company_name]
    @assessment.company_industry = params[:company_industry]
    @assessment.company_size = params[:company_size]

    update_last_step(@assessment, "qualify")

    if @assessment.save
      redirect_to qualify_path(token: @assessment.invite_token)
    else
      flash.now[:alert] = @assessment.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def load_assessment
    @assessment = Assessment.find_by(invite_token: params[:token])
  end
end
