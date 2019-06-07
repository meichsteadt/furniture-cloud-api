class EditUserStores < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :show_prices, :boolean, default: true
    remove_column :users, :promotions, :boolean, default: true
    remove_column :users, :markup_default, :float,   default: 2.2

    add_column :stores, :show_prices, :boolean, default: true
    add_column :stores, :promotions, :boolean, default: true
    add_column :stores, :markup_default, :float,   default: 2.2

    remove_column :stores, :name, :string
    remove_column :stores, :address, :string
    remove_column :stores, :city, :string
    remove_column :stores, :state, :string
    remove_column :stores, :zip, :integer
    remove_column :stores, :phone, :string
    remove_column :stores, :email, :string
    remove_column :stores, :hours, :string
  end
end
