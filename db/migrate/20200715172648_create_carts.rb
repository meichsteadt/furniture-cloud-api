class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.integer :visit_id, foreign_key: true
      t.belongs_to :customer, foreign_key: true
    end
  end
end
