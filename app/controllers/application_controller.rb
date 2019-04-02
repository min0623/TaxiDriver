class ApplicationController < ActionController::API
  include CommandExecuter
  include ResponseFormatter

  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: unauthorized_json unless @current_user
  end

  def unauthorized_json
    get_error_response(:unauthorized, I18n.t('errors.unauthorized'))
  end
end
