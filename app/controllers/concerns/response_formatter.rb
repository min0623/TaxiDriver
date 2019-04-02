module ResponseFormatter

  def get_response(code = :ok, data = nil, errors = nil, message = nil)
    { code: code, data: data, errors: errors, message: message }.to_json
  end

  def get_success_response(data, message = nil)
    get_response(:ok, data, nil, message)
  end

  def get_error_response(code, errors)
    get_response(code, nil, errors, nil)
  end

  def parse_error_response(code, field, type, message)
    errors = { field => [{ type => message }] }
    get_error_response code, errors
  end
end