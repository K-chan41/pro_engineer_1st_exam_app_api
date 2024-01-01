class Api::V1::UsersController < Api::V1::BaseController
  def show
    render json: UserSerializer.new(current_user).serializable_hash.to_json
  end
end
