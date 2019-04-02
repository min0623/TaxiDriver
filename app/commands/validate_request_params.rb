class ValidateRequestParams
  prepend SimpleCommand

  def initialize(params, model, fields)
    @params = params
    @model = model
    @fields = fields
  end

  def call
    validate_fields
    return nil if errors.any?

    require_params
  end

  private

  def validate_fields
    @fields.each do |field|
      errors.add("#{@model}.#{field}", required: "#{field}은(는) 필수입니다.") unless
          @params[@model][field].present?
    end
  end

  def require_params
    @params.require(@model).permit(@fields)
  end
end