class CreateMessages < ActiveRecord::Migration[5.2]
  def up
    create_table :messages do |t|
      t.integer :chat_id, :null=>false
      t.integer :sender_id, :null=>false
      t.integer :receiver_id, :null=>false
      t.string :token, :null=>false
      t.text :message, :null=>false
      t.timestamp :deleted_at, :null=>true
      t.timestamps
    end
    add_index :messages, :chat_id
    add_index :messages, :sender_id
    add_index :messages, :receiver_id
  end
  def down
    drop_table :messages
  end
end
