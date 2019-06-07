class AddLogoStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :logo, :string
  end
end
