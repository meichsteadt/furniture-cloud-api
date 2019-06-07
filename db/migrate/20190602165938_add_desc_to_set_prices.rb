class AddDescToSetPrices < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :set_desc, :string
  end
end
