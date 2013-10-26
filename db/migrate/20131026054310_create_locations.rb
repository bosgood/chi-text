class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :district
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :website
      t.string :location
      t.decimal :latitude
      t.decimal :longitude
    end
  end
end
