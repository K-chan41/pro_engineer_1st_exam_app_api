class Api::V1::QuestionsController < Api::V1::BaseController
  skip_before_action :authenticate, only: [:filter]

  def filter
    subject_ids = params[:subject_ids]
    questions = Question.includes(:choices, :subject, :label).where(subject_id: subject_ids).order(:id)
    
    # Serialize questions with related choices, subjects, and labels
    json_string = QuestionSerializer.new(questions, options).serializable_hash.to_json
    render json: json_string
  end

  def shuffle
    questions = Question.includes(:choices, :subject, :label).order('RANDOM()').limit(10)
    json_string = QuestionSerializer.new(questions, options).serializable_hash.to_json
    render json: json_string
  end

  private

  def options
    {
      include: [:choices, :subject, :label] # 'include' オプションを設定
    }
  end
end
