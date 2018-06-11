class CreateSetPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :set_prices do |t|
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
