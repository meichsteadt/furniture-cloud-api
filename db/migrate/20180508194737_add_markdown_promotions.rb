class AddMarkdownPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions, :discount, :decimal, default: 0.9
  end
end
