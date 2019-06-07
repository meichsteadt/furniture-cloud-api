class AddMarkupDefault < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :markup_default, :float, default: 2.2
  end
end
