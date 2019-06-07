class CreateProductsSetTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :products_set_types do |t|
      t.integer :product_id
      t.integer :set_type_id
    end
  end
end
