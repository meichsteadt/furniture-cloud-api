class AddSetNameAndPrice < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :set_name, :string
  end
end
