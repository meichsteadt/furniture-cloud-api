class AddStoreIdAhoy < ActiveRecord::Migration[5.0]
  def change
    add_column :ahoy_visits, :store_id, :integer
    add_column :ahoy_events, :store_id, :integer
  end
end
