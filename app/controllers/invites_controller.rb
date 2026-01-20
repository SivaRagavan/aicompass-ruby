class InvitesController < ApplicationController
  include AssessmentScoring

  before_action :load_assessment

  def show
    if @assessment.nil?
      render :missing, status: :not_found
      return
    end

    if @assessment.status != "active"
      @message = "Assessment cancelled."
      render :unavailable, status: :forbidden
      return
    end

    if @assessment.expired?
      @message = "Invite expired."
      render :unavailable, status: :forbidden
      return
    end

    if @assessment.progress_data&.fetch("last_step", nil).present?
      last_step = @assessment.progress_data["last_step"]
      if last_step != "invite"
        redirect_to resume_path_for(@assessment)
        return
      end
    end

    update_last_step(@assessment, "invite")
    @assessment.save

    @profile = @assessment.exec_profile.presence || {}
  end

  def update
    unless @assessment&.active?
      redirect_to invite_path(params[:token])
      return
    end

    @assessment.exec_profile = {
      "name" => params[:exec_name],
      "email" => params[:exec_email]
    }
    @assessment.company_name = params[:company_name]
    @assessment.company_industry = params[:company_industry]
    @assessment.company_size = params[:company_size]
    update_progress(@assessment, 0, 0)
    update_last_step(@assessment, "company")

    if @assessment.save
      redirect_to company_path(token: @assessment.invite_token)
    else
      flash.now[:alert] = @assessment.errors.full_messages.to_sentence
      @profile = @assessment.exec_profile
      render :show, status: :unprocessable_entity
    end
  end

  private

  def load_assessment
    @assessment = Assessment.find_by(invite_token: params[:token])
  end
end
