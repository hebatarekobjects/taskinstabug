require 'securerandom'
class Api::V1::ApplicationsController < ApplicationController
    skip_before_action :verify_authenticity_token
    include Api::V1::ApplicationsHelper

    def list
        @applications = Application.where({:deleted_at => nil}).paginate(page: params[:page], per_page: 10).order("applications.created_at DESC")
        render json: format_list_response(@applications), :status=>200
    end

    def show
        if !params.has_key? :id 
            render json: format_invalid_input_response, :status=>405
        else
            @application = Application.where({:token=>params[:id],:deleted_at => nil}).first
            if @application.nil?
                render json: format_not_found_response, :status=>404
            else
                render json: format_show_response(@application), :status=>200
            end
        end
    end

    def destroy
        if !params.has_key? :id 
            render json: format_invalid_input_response, :status=>405
        else
            @application = Application.where({:token=>params[:id],:deleted_at => nil}).first
            if @application.nil?
                render json: format_not_found_response, :status=>404
            else
                @application.update_attributes({:deleted_at=>Time.now})
                render json: format_delete_response, :status=>200
            end
        end
    end

    def new
        
        @application = Application.new
        if !params.has_key? :client_name
            render json: format_invalid_input_response, :status=>405
        else 
            applications_count = Application.where({:deleted_at => nil,:client_name=>params[:client_name]}).count
            if applications_count > 0
                render json: format_already_exist_response, :status=>405
            else 
                @application.update_attributes({:client_name=>params[:client_name],:token=>SecureRandom.uuid})
                render json: format_show_response(@application), :status=>200
            end
        end
    end

    def edit
        if !params.has_key? :id 
            render json: format_invalid_input_response, :status=>405
        else
            @application = Application.where({:token=>params[:id],:deleted_at => nil}).first
            if @application.nil?
                render json: format_not_found_response, :status=>404
            else
                where = "deleted_at is ? and client_name = ? and token <> ?"
                applications_count = Application.where(where,nil,params['client_name'],params[:id]).count
                if applications_count > 0
                    render json: format_already_exist_response, :status=>405
                else 
                    @application.update_attributes({:client_name=>params['client_name']})
                    render json: format_show_response(@application), :status=>200
                end
            end
        end
    end

end
