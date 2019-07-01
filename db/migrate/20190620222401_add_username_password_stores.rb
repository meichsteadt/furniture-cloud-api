class AddUsernamePasswordStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :key, :string
    add_column :stores, :password_digest, :string
  end
end
