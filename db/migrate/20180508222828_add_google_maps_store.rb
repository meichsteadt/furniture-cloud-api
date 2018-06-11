class AddGoogleMapsStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :google_maps, :string
    remove_column :promotions, :url, :string
  end
end
