class CreateProductsPromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :products_promotions do |t|
      t.references :product
      t.references :promotion
    end
  end
end
