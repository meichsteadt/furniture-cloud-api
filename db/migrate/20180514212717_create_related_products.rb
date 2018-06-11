class CreateRelatedProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :related_products do |t|
      t.references :product
      t.integer :related_product_id
    end
  end
end
