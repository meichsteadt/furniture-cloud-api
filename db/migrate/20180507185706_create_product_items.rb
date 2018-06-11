class CreateProductItems < ActiveRecord::Migration[5.0]
  def change
    create_table :product_items do |t|
      t.references :product
      t.string :name
      t.string :dimensions
      t.decimal :price

      t.timestamps
    end
  end
end
