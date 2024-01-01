class Api::V1::BaseController < ApplicationController
  include Api::ExceptionHandler
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate
  before_action :set_cors_headers # CORS設定用のbefore_action

  protected

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      @_current_user ||= ApiKey.active.find_by(access_token: token)&.user
    end
  end

  def current_user
    @_current_user
  end

  def set_access_token!(user)
    api_key = user.activate_api_key!
    response.headers['AccessToken'] = api_key.access_token
  end

    # CORS設定
    def set_cors_headers
      headers['Access-Control-Allow-Origin'] = '*' # ここで許可するオリジンを設定
      headers['Access-Control-Expose-Headers'] = 'AccessToken'
    end

  private

  def form_authenticity_token; end
end
