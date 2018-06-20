class AddUserIdSizes < ActiveRecord::Migration[5.0]
  def change
    change_table :sizes do |t|
      t.references :user
    end
  end
end
