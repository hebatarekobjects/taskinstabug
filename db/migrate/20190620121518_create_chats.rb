class CreateChats < ActiveRecord::Migration[5.2]
  def up
    create_table :chats do |t|
      t.integer :application_intiator_id, :null=>false
      t.integer :application_receiver_id, :null=>false
      t.integer :message_count, :null=>false, :default=>0
      t.string :token, :null=>false
      t.timestamps
    end
    add_index :chats, :application_intiator_id
    add_index :chats, :application_receiver_id
  end
  def down
    drop_table :chats
  end
end
