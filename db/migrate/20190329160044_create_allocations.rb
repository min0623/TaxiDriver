class CreateAllocations < ActiveRecord::Migration[5.2]
  def change
    create_table :allocations do |t|
      t.integer :driver_id
      t.integer :passenger_id
      t.integer :status
      t.string :address

      t.timestamps
    end
  end
end
