class CreateCategoriesUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :categories_users do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
    end
  end
end
