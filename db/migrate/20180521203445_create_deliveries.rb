class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|
      t.references :store, foreign_key: true
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
