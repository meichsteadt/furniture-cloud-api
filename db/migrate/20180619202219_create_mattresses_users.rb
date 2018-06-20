class CreateMattressesUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :mattresses_users do |t|
      t.references :mattress
      t.references :user
    end
  end
end
