class CreateUser
  prepend SimpleCommand
  include ResponseFormatter

  def initialize(params)
    @params = params
    @fields = %i[email password role]
  end

  def call
    command = ValidateRequestParams.call(@params, :user, @fields)

    if command.success?
      @user = User.new(command.result)
      save
    else
      error command.errors
    end
  end

  private

  def save
    if @user.save
      get_success_response(UserSerializer.serialize(@user),
                           I18n.t('user.create.success'))
    else
      error @user.errors
    end
  end

  def error(errors)
    get_error_response :invalid_params, errors
  end
end