class Message < ApplicationRecord
    belongs_to :chat, foreign_key: 'chat_id'
    belongs_to :sender,class_name: 'Application', foreign_key: 'sender_id'
    belongs_to :receiver,class_name: 'Application', foreign_key: 'receiver_id'  
end
