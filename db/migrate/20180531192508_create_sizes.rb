class CreateSizes < ActiveRecord::Migration[5.0]
  def change
    create_table :sizes do |t|
      t.references :mattress, foreign_key: true
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
