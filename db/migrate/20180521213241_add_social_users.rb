class AddSocialUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :yelp
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :google_reviews_id
      t.string :yellow_pages
    end
  end
end
