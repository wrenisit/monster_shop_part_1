class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :receiver_id
      t.string :references
      t.string :sender_id
      t.string :references
      t.string :title
      t.string :string
      t.string :message
      t.string :text
    end
  end
end
