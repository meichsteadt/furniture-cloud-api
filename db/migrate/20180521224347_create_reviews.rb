class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :store, foreign_key: true
      t.string :name
      t.text :review
      t.float :stars

      t.timestamps
    end
  end
end
