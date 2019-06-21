class CreateApplications < ActiveRecord::Migration[5.2]
  def up
    create_table :applications do |t|
      t.integer :chat_count, :null=>false, :default=>0
      t.string :client_name, :null=>false
      t.string :token, :null=>false
      t.timestamp :deleted_at, :null=>true
      t.timestamps
    end
  end
  def down 
    drop_table :applications
  end
end
