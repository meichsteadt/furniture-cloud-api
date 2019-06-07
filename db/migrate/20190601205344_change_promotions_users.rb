class ChangePromotionsUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :promotions_users
    add_column :promotions, :user_id, :integer
  end
end
