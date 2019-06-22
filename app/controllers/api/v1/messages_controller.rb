class Api::V1::MessagesController < ApplicationController
    skip_before_action :verify_authenticity_token
    include Api::V1::MessagesHelper

    def list
        @chat = Chat.where({:token=>params[:chat_token]}).first
        page = ((!params.has_key?:page) || params[:page].blank? || params[:page].to_s=="0")? 1 : params[:page]
        if !@chat.nil?
            @messages=nil
            if ((params.has_key? :search_query) && (!params[:search_query].blank?))
                Message.__elasticsearch__.create_index!
                Message.import
                @messages=Message.search(
                    {
                        "query": {
                            "bool": {
                                "must": [
                                    "match_phrase":{
                                        "message":{
                                            "query":params[:search_query]
                                        }
                                    }
                                ],
                                "filter": [
                                    { "term":  { "chat_id":@chat.id } }
                                ]
                            }
                        }
                    }
                )
                render json: format_list_elastic_response(@messages.results), :status=>200
            else
                where = "messages.deleted_at is ? and messages.chat_id=?"
                @messages = Message.where(where,nil,@chat.id).paginate(page: page, per_page: 10).order("messages.created_at DESC")
                render json: format_list_response(@messages), :status=>200
            end
        else
            render json: format_not_found_response, :status=>404
        end
    end

    def show
        if ((!params.has_key? :id) || params[:id].blank?)
            render json: format_invalid_input_response, :status=>405
        else
            @message = Message.where({:token=>params[:id],:deleted_at => nil}).first
            if @message.nil?
                render json: format_message_not_found_response, :status=>404
            else
                render json: format_show_response(@message), :status=>200
            end
        end
    end

    def destroy
        if ((!params.has_key? :id) || params[:id].blank?)
            render json: format_invalid_input_response, :status=>405
        else
            data = {
                :token=>params[:id],
                :action=>"destroy"
            }
            MessageQueueJob.perform_later data
            sleep 2
            render json: format_delete_response, :status=>200
        end
    end

    def new
        if ((!params.has_key? :sender_token) || params[:sender_token].blank?)
            render json: format_invalid_input_response, :status=>405
        elsif ((!params.has_key? :receiver_token) || params[:receiver_token].blank?)
            render json: format_invalid_input_response, :status=>405
        elsif ((!params.has_key? :body) || params[:body].blank?)
            render json: format_invalid_input_response, :status=>405
        elsif ((!params.has_key? :chat_token) || params[:chat_token].blank?)
            render json: format_invalid_input_response, :status=>405
        else
            data = {
                :sender_id=>params[:sender_token],
                :receiver_id=>params[:receiver_token],
                :chat_id=>params[:chat_token],
                :action=>"create",
                :body=>params[:body]
            }
            MessageQueueJob.perform_later data
            sleep 2
            render json: format_create_response, :status=>200
        end
    end
end
