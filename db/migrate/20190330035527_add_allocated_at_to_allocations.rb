class AddAllocatedAtToAllocations < ActiveRecord::Migration[5.2]
  def change
    add_column :allocations, :allocated_at, :date
  end
end
