class CreateParentCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :parent_categories do |t|
      t.string :name
      t.string :image
      t.references :user
    end

    remove_column :categories, :parent_category, :string
    add_column :categories, :parent_category_id, :integer
  end
end
