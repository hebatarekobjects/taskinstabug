module Api::V1::MessagesHelper
    def format_list_response messages
        data = []
        messages.map { |message|
            data.push({
                :token => message.token,
                :sender_token => message.sender.token,
                :receiver_token => message.receiver.token,
                :chat_token => message.chat.token,
                :message => message.message,
                :created_at => message.created_at.to_i,
                :updated_at => message.updated_at.to_i
            })
        }
        return {
            :code  => 200,
            :status =>true,
            :message => "successfull operation",
            :data => data
        }
    end

    def format_list_elastic_response messages
        data = []
        messages.map { |message|
            @sender = Application.find(message.sender_id)
            @receiver = Application.find(message.receiver_id)
            @chat = Chat.find(message.chat_id)
            data.push({
                :token => message.token,
                :sender_token => @sender.token,
                :receiver_token => @receiver.token,
                :chat_token => @chat.token,
                :message => message.message,
                :created_at => message.created_at.to_i,
                :updated_at => message.updated_at.to_i
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
            :message => "chat is not found",
        }
    end

    def format_message_not_found_response
        return {
            :code  => 404,
            :status =>false,
            :message => "message is not found",
        }
    end

    def format_show_response(message)
        return {
            :code  => 200,
            :status =>true,
            :message => "successfull operation",
            :data =>{
                :token => message.token,
                :sender_token => message.sender.token,
                :receiver_token => message.receiver.token,
                :chat_token => message.chat.token,
                :message => message.message,
                :created_at => message.created_at.to_i,
                :updated_at => message.updated_at.to_i
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
            :message => "message is added to delete quque successfully",
        }
    end

    def format_create_response
        return {
            :code  => 200,
            :status =>true,
            :message => "message is added to create queue successfully"
        }
    end
end
