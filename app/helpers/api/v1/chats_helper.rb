module Api::V1::ChatsHelper
    def format_list_response chats
        data = []
        chats.map { |chat|
            data.push({
                :token => chat.token,
                :intiator_token => chat.application_intiator.token,
                :receiver_token => chat.application_receiver.token,
                :message_count => chat.message_count,
                :created_at => chat.created_at.to_i,
                :updated_at => chat.updated_at.to_i
            })
        }
        return {
            :code  => 200,
            :status =>true,
            :message => "successfull operation",
            :data => data
        }
    end

    def format_invalid_input_response
        return {
            :code  => 405,
            :status =>false,
            :message => "invalid input",
        }
    end

    def format_not_found_response
        return {
            :code  => 404,
            :status =>false,
            :message => "application is not found",
        }
    end

    def format_show_response(chat)
        return {
            :code  => 200,
            :status =>true,
            :message => "successfull operation",
            :data =>{
                :token => chat.token,
                :intiator_token => chat.application_intiator.token,
                :receiver_token => chat.application_receiver.token,
                :message_count => chat.message_count,
                :created_at => chat.created_at.to_i,
                :updated_at => chat.updated_at.to_i
            }
        }
    end

    def format_already_exist_response
        return {
            :code  => 405,
            :status =>false,
            :message => "application is already exist",
        }
    end

    def format_delete_response
        return {
            :code  => 200,
            :status =>true,
            :message => "application is added to delete quque successfully",
        }
    end

    def perform_delete_process params
        @chat = chat.where({:token=>params[:id],:deleted_at => nil}).first
        if !@chat.nil?
            @chat.update_attributes({:deleted_at=>Time.now})
            @intiator = @chat.application_intiator
            intiator_chat_count = @intiator.chat_count
            @intiator.update_attributes({:chat_count=>(intiator_chat_count-1)})
            @receiver = @chat.application_receiver
            receiver_chat_count = @receiver.chat_count
            @receiver.update_attributes({:chat_count=>(receiver_chat_count-1)})
            @messages = @chat.messages
            @messages.each { |m|
                m.update_attributes({:deleted_at=>Time.now})
            }
        end
    end

    def format_create_response
        return {
            :code  => 200,
            :status =>true,
            :message => "chat is added to create queue successfully"
        }
    end
end
