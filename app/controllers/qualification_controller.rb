class QualificationController < ApplicationController
  include AssessmentScoring

  before_action :load_assessment

  def edit
    redirect_to invite_path(params[:token]) unless @assessment&.active?
    @questions = BenchmarkData.qualify_questions
  end

  def update
    unless @assessment&.active?
      redirect_to invite_path(params[:token])
      return
    end

    answers = params.fetch(:answers, {}).to_unsafe_h
    pillar_ids = BenchmarkData.qualify_questions.flat_map do |question|
      selected = answers[question[:id]]
      option = question[:options].find { |item| item[:value] == selected }
      option ? option[:recommended_pillars] : []
    end

    @assessment.selections = BenchmarkData.build_selections(pillar_ids.uniq)
    @assessment.responses = { "qualification" => answers }
    update_last_step(@assessment, "modules")

    if @assessment.save
      redirect_to modules_path(token: @assessment.invite_token)
    else

      flash.now[:alert] = @assessment.errors.full_messages.to_sentence
      @questions = BenchmarkData.qualify_questions
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def load_assessment
    @assessment = Assessment.find_by(invite_token: params[:token])
  end
end
