class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :phone
      t.string :email
      t.string :hours
      t.integer :user_id
      
      t.timestamps
    end
  end
end
