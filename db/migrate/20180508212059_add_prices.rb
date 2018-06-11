class AddPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :prices do |t|
      t.references :product_item
      t.references :user
      t.decimal :price
    end
  end
end
