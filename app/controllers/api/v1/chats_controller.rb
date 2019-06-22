require 'securerandom'

class Api::V1::ChatsController < ApplicationController
    skip_before_action :verify_authenticity_token
    include Api::V1::ChatsHelper

    def list
        @application = Application.where({:token=>params[:application_token]}).first
        page = ((!params.has_key?:page) || params[:page].blank? || params[:page].to_s=="0")? 1 : params[:page]

        if !@application.nil?
            puts @application.inspect
            where = "chats.deleted_at is ? and (chats.application_intiator_id=? or chats.application_receiver_id=?)"
            @chats = Chat.where(where,nil,@application.id,@application.id).paginate(page: page, per_page: 10).order("chats.created_at DESC")
            render json: format_list_response(@chats), :status=>200
        else
            render json: format_not_found_response, :status=>404
        end
    end

    def show
        if ((!params.has_key? :id) || params[:id].blank?)
            render json: format_invalid_input_response, :status=>405
        else
            @chat = Chat.where({:token=>params[:id],:deleted_at => nil}).first
            if @chat.nil?
                render json: format_chat_not_found_response, :status=>404
            else
                render json: format_show_response(@chat), :status=>200
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
            ChatQueueJob.perform_later data
            sleep 2
            render json: format_delete_response, :status=>200
        end
    end

    def new
        if ((!params.has_key? :sender_token) || params[:sender_token].blank?)
            render json: format_invalid_input_response, :status=>405
        elsif ((!params.has_key? :receiver_token) || params[:receiver_token].blank?)
            render json: format_invalid_input_response, :status=>405
        else
            data = {
                :sender_id=>params[:sender_token],
                :receiver_id=>params[:receiver_token],
                :action=>"create"
            }
            ChatQueueJob.perform_later data
            sleep 2
            render json: format_create_response, :status=>200
        end
    end

end
