class AddCustomersAhoy < ActiveRecord::Migration[5.0]
  def change
    add_column :ahoy_visits, :customer_id, :integer
    add_column :ahoy_events, :customer_id, :integer
  end
end
