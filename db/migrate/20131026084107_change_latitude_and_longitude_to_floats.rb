class ChangeLatitudeAndLongitudeToFloats < ActiveRecord::Migration
  def change
    change_table :locations do |t|
      t.change :latitude, :float
      t.change :longitude, :float
    end
  end
end
