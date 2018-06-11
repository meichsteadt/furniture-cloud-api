class CreateUserKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :user_keys do |t|
      t.references :user, foreign_key: true
      t.string :password_digest
      t.string :key

      t.timestamps
    end
  end
end
