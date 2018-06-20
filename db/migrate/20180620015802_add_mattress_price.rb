class AddMattressPrice < ActiveRecord::Migration[5.0]
  def change
    add_column :sizes, :mat_only, :decimal
  end
end
