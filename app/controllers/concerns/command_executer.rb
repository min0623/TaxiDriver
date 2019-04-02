module CommandExecuter

  def call(simple_command, *args)
    command = simple_command.call(*args)

    if command.success?
      render json: command.result
    else
      render json: get_error_response(400, command.errors)
    end
  end
end