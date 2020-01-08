class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :receiver_id, foreign_key: true
      t.references :sender_id, foreign_key: true
      t.string :title
      t.string :string
      t.string :message
      t.string :text
      t.timestamps
    end
  end
end
