class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.string :logo
      t.string :name
      t.string :brand_type

      t.timestamps
    end
  end
end
