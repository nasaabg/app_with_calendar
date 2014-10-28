class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
