class ChangeAllocatedAtToDateTimeInAllocations < ActiveRecord::Migration[5.2]
  def change
    change_column :allocations, :allocated_at, :datetime
  end
end
