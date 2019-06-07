class CreateNavTops < ActiveRecord::Migration[5.0]
  def change
    create_table :nav_tops do |t|
      t.string :copy
      t.integer :user_id
      t.string :color
      t.string :link
      t.string :shape
      
      t.timestamps
    end
  end
end
