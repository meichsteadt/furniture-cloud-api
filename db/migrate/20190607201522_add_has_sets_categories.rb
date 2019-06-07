class AddHasSetsCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :has_sets, :boolean, default: false
  end
end
