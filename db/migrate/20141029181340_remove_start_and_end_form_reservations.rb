class RemoveStartAndEndFormReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :start
    remove_column :reservations, :end
  end
end
