class CreateInfoRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :info_requests do |t|
      t.references :store_id
      t.references :product_id
      t.references :customer_id

      t.timestamps
    end
  end
end
