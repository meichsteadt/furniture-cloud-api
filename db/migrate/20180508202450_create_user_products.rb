class CreateUserProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :user_products do |t|
      t.references :user
      t.references :product
      t.decimal :price

      t.timestamps
    end
  end
end
