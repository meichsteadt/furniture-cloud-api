class AddUrlStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :url, :string
    add_column :stores, :favicon, :string
  end
end
