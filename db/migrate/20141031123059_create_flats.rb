class CreateFlats < ActiveRecord::Migration
  def change
    create_table :flats do |t|
      t.string :address
      t.integer :number_of_rooms
      t.float :area
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
