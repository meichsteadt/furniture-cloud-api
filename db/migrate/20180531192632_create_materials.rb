class CreateMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :materials do |t|
      t.string :name
      t.string :image
      t.text :benefits

      t.timestamps
    end
  end
end
