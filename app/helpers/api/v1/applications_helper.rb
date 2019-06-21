module Api::V1::ApplicationsHelper
    def format_list_response applications
        data = []
        applications.map { |e|
            data.push({
                :token => e.token,
                :client_name => e.client_name,
                :chat_count => e.chat_count,
                :created_at => e.created_at.to_i,
                :updated_at => e.updated_at.to_i
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

    def format_show_response(application)
        return {
            :code  => 200,
            :status =>true,
            :message => "successfull operation",
            :data =>{
                :token => application.token,
                :client_name => application.client_name,
                :chat_count => application.chat_count,
                :created_at => application.created_at.to_i,
                :updated_at => application.updated_at.to_i
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
            :message => "application is deleted successfully",
        }
    end
end
