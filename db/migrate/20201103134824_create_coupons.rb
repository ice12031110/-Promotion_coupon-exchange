class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :serial_number
      t.belongs_to :exchange, null: false, foreign_key: true

      t.timestamps
    end
  end
end
