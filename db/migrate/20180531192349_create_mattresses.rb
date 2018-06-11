class CreateMattresses < ActiveRecord::Migration[5.0]
  def change
    create_table :mattresses do |t|
      t.string :name
      t.references :brand, foreign_key: true
      t.string :comfort
      t.string :image
      t.text :description
      t.integer :warranty

      t.timestamps
    end
  end
end
