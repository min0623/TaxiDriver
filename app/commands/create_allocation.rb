# frozen_string_literal: true

class CreateAllocation
  prepend SimpleCommand
  include ResponseFormatter

  def initialize(params, user)
    @params = params
    @user = user
    @fields = %i[address]
  end

  def call
    command = ValidateRequestParams.call(@params, :allocation, @fields)

    if command.success?
      @allocation = Allocation.new(passenger: @user,
                                   address: command.result[:address])
      save
    else
      error command.errors
    end
  end

  private

  def save
    if @allocation.save
      get_success_response(AllocationSerializer.serialize(@allocation),
                           I18n.t('allocation.create.success'))
    else
      error @allocation.errors
    end
  end

  def error(errors)
    get_error_response(:invalid_params, errors)
  end
end