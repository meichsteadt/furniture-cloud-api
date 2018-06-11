class AddImageCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :image, :string
    add_column :products, :thumbnail, :string
  end
end
