class AcceptAllocation
  prepend SimpleCommand
  include ResponseFormatter

  def initialize(id, user)
    @id = id
    @user = user
  end

  def call
    allocation = Allocation.find_by_id(@id)
    return not_found unless allocation
    return allocated if allocation.allocated?

    if allocation.update(driver: @user,
                         status: 'allocated',
                         allocated_at: DateTime.current)
      get_success_response(AllocationSerializer.serialize(allocation),
                           I18n.t('allocation.allocate.success'))
    else
      get_error_response :invalid_params, allocation.errors
    end
  end

  private

  def not_found
    parse_error_response(:not_found,
                         :allocation,
                         :not_found,
                         I18n.t('allocation.errors.not_found'))
  end

  def allocated
    parse_error_response(:invalid_params,
                         :allocation,
                         :invalid,
                         I18n.t('allocation.allocate.allocated'))
  end
end