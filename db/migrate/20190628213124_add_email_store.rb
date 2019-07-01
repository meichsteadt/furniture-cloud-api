class AddEmailStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :email, :string
  end
end
