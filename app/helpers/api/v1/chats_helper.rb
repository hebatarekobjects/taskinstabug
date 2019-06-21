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

    def format_chat_not_found_response
        return {
            :code  => 404,
            :status =>false,
            :message => "chat is not found",
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
            :message => "chat is added to delete quque successfully",
        }
    end

    def format_create_response
        return {
            :code  => 200,
            :status =>true,
            :message => "chat is added to create queue successfully"
        }
    end
end
