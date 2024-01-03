class Api::V1::UsersController < Api::V1::BaseController
  def show
    render json: UserSerializer.new(current_user, options).serializable_hash.to_json
  end

  private

  def options
    {
      include: [:flags, :user_question_relations] # 'include' オプションを設定
    }
  end
end
