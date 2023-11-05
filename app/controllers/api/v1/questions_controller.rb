class Api::V1::QuestionsController < Api::V1::BaseController
  def filter
    subject_ids = params[:subject_ids]
    questions = Question.includes(:choices, :subject, :label).where(subject_id: subject_ids)
    
    # Serialize questions with related choices, subjects, and labels
    json_string = QuestionSerializer.new(questions, options).serializable_hash.to_json
    render json: json_string
  end

  private

  def options
    options = {}
    options[:include] = [:choices, :subject, :label]
    options
  end
end
