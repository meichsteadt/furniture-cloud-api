class FixInfoRequests < ActiveRecord::Migration[5.0]
  def change
    drop_table :info_requests
    create_table :info_requests do |t|
      t.references :store
      t.references :product
      t.integer :customer_id
      t.string :name
      t.string :email
      t.string :note

      t.timestamps
    end
  end
end
