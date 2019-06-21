class ChatQueueJob < ApplicationJob
  queue_as :default
  include Api::V1::ChatsHelper
  def perform(params)
    if params[:action] == "destroy"
      Chat.perform_delete params
    elsif params[:action] == "create"
      Chat.perform_create params
    end
  end
end
