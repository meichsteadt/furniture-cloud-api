class ChangeSocials < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :yelp, :string
    remove_column :users, :facebook, :string
    remove_column :users, :instagram, :string
    remove_column :users, :google_reviews_id, :string
    remove_column :users, :twitter, :string
    remove_column :users, :yellow_pages, :string

    add_column :stores, :yelp, :string
    add_column :stores, :facebook, :string
    add_column :stores, :instagram, :string
    add_column :stores, :google_reviews_id, :string
    add_column :stores, :twitter, :string
    add_column :stores, :yellow_pages, :string
  end
end
