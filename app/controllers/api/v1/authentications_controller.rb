class Api::V1::AuthenticationsController < Api::V1::BaseController
  skip_before_action :authenticate

  def create
    @user = login(params[:email], params[:password])
    puts @user

    raise ActiveRecord::RecordNotFound unless @user

    json_string = UserSerializer.new(@user).serializable_hash.to_json
    api_key = @user.activate_api_key!
    response.headers['AccessToken'] = api_key.access_token
    render json: json_string
  end
end
