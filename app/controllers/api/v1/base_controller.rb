class Api::V1::BaseController < ApplicationController
  include Api::ExceptionHandler

  private

  def form_authenticity_token; end
end
