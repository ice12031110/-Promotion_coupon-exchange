class CreateExchanges < ActiveRecord::Migration[6.0]
  def change
    create_table :exchanges do |t|
      t.string :company_name, null: false
      t.integer :company_number, null: false, unique: true
      t.integer :phone_number, null: false

      t.timestamps
    end
  end
end
