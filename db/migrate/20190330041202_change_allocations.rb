class ChangeAllocations < ActiveRecord::Migration[5.2]
  def change
    change_column_default :allocations, :status, 'waiting'
  end
end
