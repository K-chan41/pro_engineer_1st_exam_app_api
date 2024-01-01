class Api::V1::AuthenticationsController < Api::V1::BaseController
  skip_before_action :authenticate, only: [:create]

  def create
    user_params = authentication_params
    @user = login(user_params[:email], user_params[:password])
    puts @user

    if @user
      json_string = UserSerializer.new(@user).serializable_hash.to_json
      api_key = @user.activate_api_key!
      response.headers['AccessToken'] = api_key.access_token
      render json: json_string
    else
      render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.api_keys.active.update_all(expires_at: Time.current)
      head :ok
    else
      render json: { error: 'Logout failed' }, status: :unprocessable_entity
    end
  end

  private

  def authentication_params
    params.require(:user).permit(:email, :password)
  end
end
