class Api::V1::QuestionsController < Api::V1::BaseController
  skip_before_action :authenticate, only: [:filter]

  def filter
    subject_ids = params[:subject_ids]
    questions = Question.includes(:choices, :subject, :label).where(subject_id: subject_ids).order(:id)

    raise ActiveRecord::RecordNotFound, 'Questions not found' if questions.empty?

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
    mistaken_question_ids = UserQuestionRelation
                                  .joins("INNER JOIN questions ON questions.id = user_question_relations.question_id")
                                  .where(user_id: current_user.id)
                                  .where("user_question_relations.answer != questions.correct_answer_no")
                                  .select(:question_id)
                                  .group(:question_id)
                                  .order('MAX(user_question_relations.updated_at) DESC')
                                  .limit(10)
                                  .pluck(:question_id)

  
    mistaken_questions = Question.includes(:choices, :subject, :label).where(id: mistaken_question_ids)
    json_string = QuestionSerializer.new(mistaken_questions, options).serializable_hash.to_json
    render json: json_string
  end

  def flagged_questions
    # current_user がフラグした問題を取得し、重複を削除
    flagged_questions_ids = Flag
                                .where(user: current_user)
                                .select(:question_id)
                                .group(:question_id)
                                .order('MAX(flags.updated_at) DESC')
                                .limit(10)
                                .pluck(:question_id)
  
    flagged_questions = Question.includes(:choices, :subject, :label).where(id: flagged_questions_ids)
    json_string = QuestionSerializer.new(flagged_questions, options).serializable_hash.to_json
    render json: json_string
  end

  private

  def options
    {
      include: [:choices, :subject, :label] # 'include' オプションを設定
    }
  end
end
