class AddReservatiobIdToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :reservation_id, :integer
    add_index :customers, :reservation_id
  end
end
