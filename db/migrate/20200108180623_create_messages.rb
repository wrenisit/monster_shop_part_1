class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :merchant_id, foreign_key: true
      t.references :user_id, foreign_key: true
      t.string :title
      t.text :body
      t.timestamps
    end
  end
end
