class AuthenticateUser
  prepend SimpleCommand
  include ResponseFormatter

  def initialize(params)
    @params = params
    @fields = %i[email password]
  end

  def call
    command = ValidateRequestParams.call(@params, :user, @fields)

    if command.success?
      if user
        get_success_response(login_json(user, token),
                             I18n.t('user.login.success'))
      else
        parse_error_response :invalid_params,
                             :user,
                             :invalid,
                             I18n.t('user.login.fail')
      end
    else
      get_error_response :invalid_params, command.errors
    end
  end

  private

  def user
    @user ||= authenticate_user
  end

  def authenticate_user
    user = User.find_by_email(@params[:user][:email])
    user if user&.authenticate(@params[:user][:password])
  end

  def token
    JsonWebToken.encode(user_id: user.id)
  end

  def login_json(user, token)
    json = UserSerializer.serialize user
    json[:token] = token

    json
  end
end