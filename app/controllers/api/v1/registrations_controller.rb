# frozen_string_literal: true

class Api::V1::RegistrationsController < Api::V1::BaseController
  skip_before_action :authenticate, only: [:create]
  before_action :set_user, only: [:destroy]

  def create
    @user = ::User.new(user_params)

    if @user.save
      json_string = UserSerializer.new(@user).serializable_hash.to_json
      api_key = @user.activate_api_key!
      response.headers['AccessToken'] = api_key.access_token
      render json: json_string
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: { message: 'User successfully deleted.' }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def set_user
    @user = current_user
  end
end
