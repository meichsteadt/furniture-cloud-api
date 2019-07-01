class AddProductIdView < ActiveRecord::Migration[5.0]
  def change
    add_column :ahoy_events, :product_id, :integer
  end
end
