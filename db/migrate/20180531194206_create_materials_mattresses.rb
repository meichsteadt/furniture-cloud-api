class CreateMaterialsMattresses < ActiveRecord::Migration[5.0]
  def change
    create_table :materials_mattresses do |t|
      t.references :mattress, foreign_key: true
      t.references :material, foreign_key: true
    end
  end
end
