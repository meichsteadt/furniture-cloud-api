class AddBooleansUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :show_prices, :boolean, default: true
    add_column :users, :promotions, :boolean, default: true
  end
end
