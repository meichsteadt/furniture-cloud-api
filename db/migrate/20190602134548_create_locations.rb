class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.integer :store_id
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :phone
      t.string :email
      t.string :hours

      t.timestamps
    end
  end
end
