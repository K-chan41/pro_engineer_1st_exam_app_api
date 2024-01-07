class Api::V1::UserQuestionRelationsController < Api::V1::BaseController

  def index
    user_question_relations = current_user.user_question_relations.includes(:question).order(updated_at: :desc)
    json_string = UserQuestionRelationSerializer.new(user_question_relations, options).serializable_hash.to_json
    render json: json_string
  end

  def create
    user_answers = params[:user_answers]

    user_answers.each do |question_id, answer_data|
      UserQuestionRelation.create(
        user_id: current_user.id,
        question_id: question_id,
        answer: answer_data[:choicedIndex]
      )
    end

    head :ok
  end

  private

  def options
    {
      include: [:question] # 'include' オプションを設定
    }
  end
end
