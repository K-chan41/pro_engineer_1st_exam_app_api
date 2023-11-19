# frozen_string_literal: true

class Api::V1::RegistrationsController < Api::V1::BaseController
  skip_before_action :authenticate

  def create
    @user = ::User.new(user_params)

    if @user.save
      json_string = UserSerializer.new(@user).serializable_hash.to_json
      api_key = @user.activate_api_key!
      response.headers['AccessToken'] = api_key.access_token
      render json: json_string
    else
      render_400(nil, @user.errors.full_messages)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
