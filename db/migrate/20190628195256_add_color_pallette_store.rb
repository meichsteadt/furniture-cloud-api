class AddColorPalletteStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :color_pallete_id, :integer, :default =>  1
  end
end
