class Message < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    belongs_to :chat, foreign_key: 'chat_id'
    belongs_to :sender,class_name: 'Application', foreign_key: 'sender_id'
    belongs_to :receiver,class_name: 'Application', foreign_key: 'receiver_id'

    def self.perform_create params
        @intiator = Application.where({:token=>params[:sender_id]}).first
        return nil if @intiator.nil?
        @receiver = Application.where({:token=>params[:receiver_id]}).first
        return nil if @receiver.nil?
        @chat = Chat.where({:token=>params[:chat_id]}).first
        return nil if @chat.nil?
        @message = self.new
        @message.token = SecureRandom.uuid
        @message.sender = @intiator
        @message.receiver = @receiver
        @message.chat=@chat
        @message.message=params[:body]
        @message.save!
        chat_message_count=@chat.message_count
        @chat.message_count=chat_message_count+1
        @chat.save!
    end

    def self.perform_delete params
        @message = self.where({:token=>params[:token],:deleted_at => nil}).first
        if !@message.nil?
            @message.deleted_at=Time.now
            @message.save!
            @chat = @message.chat
            chat_message_count = @chat.message_count
            @chat.message_count=chat_message_count-1
            @chat.save!
        end
    end
end

