class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :phone_number
      t.string :address
      t.string :language
      t.timestamps
    end
  end
end
