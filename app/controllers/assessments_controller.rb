class AssessmentsController < ApplicationController
  include Authentication
  include AssessmentScoring

  before_action :require_authentication

  def index
    @status = params[:status].presence_in(%w[active completed cancelled]) || "active"
    @assessments = current_user.assessments.recent_first.select do |assessment|
      case @status
      when "completed"
        assessment.status == "completed"
      when "cancelled"
        assessment.status == "cancelled" || assessment.expired?
      else
        assessment.status == "active" && !assessment.expired?
      end
    end
  end

  def new
    @assessment = current_user.assessments.new
  end

  def create
    assessment = current_user.assessments.new(assessment_params)
    assessment.invite_token = SecureRandom.hex(10)
    assessment.invite_expires_at = Time.current + invite_days.days
    assessment.status = "active"
    assessment.selections = BenchmarkData.build_selections([])
    assessment.exec_profile = {}
    assessment.scores = []
    assessment.responses = {}
    assessment.progress_data = {}

    if assessment.save
      update_last_step(assessment, "invite")
      assessment.save

      if params[:start_now] == "1"
        redirect_to invite_path(assessment.invite_token)
      else
        redirect_to invite_path(assessment.invite_token)
      end
    else
      @assessment = assessment
      flash.now[:alert] = assessment.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def update
    assessment = current_user.assessments.find(params[:id])
    assessment.assign_attributes(update_params)
    if params[:status] == "cancelled"
      assessment.cancelled_at = Time.current
    end
    if params[:invite_days].present?
      assessment.invite_expires_at = Time.current + params[:invite_days].to_i.days
    end

    if assessment.save
      redirect_to dashboard_path
    else
      flash[:alert] = assessment.errors.full_messages.to_sentence
      redirect_to dashboard_path
    end
  end

  private

  def assessment_params
    params.permit(:company_name, :company_industry, :company_size)
  end

  def update_params
    params.permit(:company_name, :company_industry, :company_size, :status)
  end

  def invite_days
    params[:invite_days].present? ? params[:invite_days].to_i : 30
  end
end
