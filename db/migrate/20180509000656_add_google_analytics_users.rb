class AddGoogleAnalyticsUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :google_analytics, :string
  end
end
