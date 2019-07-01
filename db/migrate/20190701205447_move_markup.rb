class MoveMarkup < ActiveRecord::Migration[5.0]
  def change
    remove_column :stores, :markup_default, :float
    add_column :users, :markup_default, :float
  end
end
