class ChangeLatitudeAndLongitudeToDecimal < ActiveRecord::Migration
  def change
    change_column :locations, :latitude, :decimal
    change_column :locations, :longitude, :decimal
  end
end
