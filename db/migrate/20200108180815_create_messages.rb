class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :merchant, foreign_key: true
      t.references :user, foreign_key: true
      t.string :title
      t.text :body
    end
  end
end
