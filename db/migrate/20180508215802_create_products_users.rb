class CreateProductsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :products_users do |t|
      t.references :user
      t.references :product
    end

    drop_table :user_products
  end
end
