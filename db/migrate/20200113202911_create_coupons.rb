class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.references :merchant, foreign_key: true
      t.integer :amount
    end
  end
end
