class ChatQueueJob < ApplicationJob
  queue_as :default
  
  def perform(params)
    if params[:action] == "destroy"
      Chat.perform_delete params
    elsif params[:action] == "create"
      Chat.perform_create params
    end
  end
end
