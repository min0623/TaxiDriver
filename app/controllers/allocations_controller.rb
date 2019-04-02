class AllocationsController < ApplicationController

  def list
    allocations = Allocation.all.order(created_at: :desc)
    render json: get_success_response(AllocationSerializer.serialize_all(allocations))
  end

  def create
    call CreateAllocation, params, @current_user
  end

  def allocate
    call AcceptAllocation, params[:id], @current_user
  end
end