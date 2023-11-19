class Api::V1::AuthenticationsController < Api::V1::BaseController
  skip_before_action :authenticate, only: [:create]

  def create
    @user = login(params[:email], params[:password])
    puts @user

    raise ActiveRecord::RecordNotFound unless @user

    json_string = UserSerializer.new(@user).serializable_hash.to_json
    api_key = @user.activate_api_key!
    response.headers['AccessToken'] = api_key.access_token
    render json: json_string
  end

  def destroy
    current_user.api_keys.active.update_all(expires_at: Time.current)
    head :ok
  end
end
