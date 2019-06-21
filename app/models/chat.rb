class Chat < ApplicationRecord
    has_many :messages
    belongs_to :application_intiator,class_name: 'Application', foreign_key: 'application_intiator_id'
    belongs_to :application_receiver,class_name: 'Application', foreign_key: 'application_receiver_id' 

    def self.perform_create params
        @intiator = Application.where({:token=>params[:sender_id]}).first
        return nil if @intiator.nil?
        @receiver = Application.where({:token=>params[:receiver_id]}).first
        return nil if @receiver.nil?
        where = "chats.deleted_at is ? and chats.application_intiator_id = ? and chats.application_receiver_id= ?"
        intiator_count = Chat.where(where, nil,@intiator.id,@receiver.id).count
        receiver_count = Chat.where(where, nil,@receiver.id,@intiator.id).count
        if intiator_count <= 0 && receiver_count <=0
            @chat = self.new
            @chat.token = SecureRandom.uuid
            @chat.application_intiator = @intiator
            @chat.application_receiver = @receiver
            @chat.save!
            intiator_chat_count=@intiator.chat_count
            receiver_chat_count=@receiver.chat_count
            @intiator.chat_count=intiator_chat_count+1
            @receiver.chat_count=receiver_chat_count+1
            @intiator.save!
            @receiver.save!
        end
    end

    def self.perform_delete params
        @chat = self.where({:token=>params[:token],:deleted_at => nil}).first
        if !@chat.nil?
            @chat.deleted_at=Time.now
            @chat.save!
            @intiator = @chat.application_intiator
            intiator_chat_count = @intiator.chat_count
            @intiator.chat_count=intiator_chat_count-1
            @intiator.save!
            @receiver = @chat.application_receiver
            receiver_chat_count = @receiver.chat_count
            @receiver.chat_count=receiver_chat_count-1
            @receiver.save!
            @messages = @chat.messages
            @messages.each { |m|
                m.deleted_at=Time.now
                m.save!
                @chat.message_count=0
                @chat.save!
            }
        end
    end
end
