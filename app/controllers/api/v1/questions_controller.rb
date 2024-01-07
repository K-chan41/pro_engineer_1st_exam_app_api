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

  def recent_mistakes
    # current_user が間違えた問題を取得し、重複を削除
    mistaken_questions = UserQuestionRelation
                            .joins(:question)
                            .where(user: current_user)
                            .where.not(answer: Question.arel_table[:correct_answer_no])
                            .select('DISTINCT ON (questions.id) questions.*')
                            .order('questions.id, user_question_relations.updated_at DESC')
                            .limit(10)
                            .map(&:question)
    json_string = QuestionSerializer.new(mistaken_questions, options).serializable_hash.to_json
    render json: json_string
  end

  private

  def options
    {
      include: [:choices, :subject, :label] # 'include' オプションを設定
    }
  end
end
