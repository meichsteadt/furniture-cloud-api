class ChangeImagesArr < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :image, :string
    add_column :products, :images, :string, array: true, default: []
  end
end
