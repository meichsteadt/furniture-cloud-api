class CreateFinancings < ActiveRecord::Migration[5.0]
  def change
    create_table :financings do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :logo
      t.boolean :credit_needed
      t.string :length
      t.boolean :bank_account
      t.string :url

      t.timestamps
    end
  end
end
