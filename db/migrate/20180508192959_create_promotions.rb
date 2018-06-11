class CreatePromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :image
      t.string :url

      t.timestamps
    end

    create_table :promotions_users do |t|
      t.references :user
      t.references :promotion
    end
  end
end
