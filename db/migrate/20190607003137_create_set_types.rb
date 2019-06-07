class CreateSetTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :set_types do |t|
      t.string :name
      t.integer :category_id
      t.string :image
         
      t.timestamps
    end
  end
end
