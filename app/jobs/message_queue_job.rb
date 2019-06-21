class MessageQueueJob < ApplicationJob
  queue_as :default

  def perform(params)
    if params[:action] == "destroy"
      Message.perform_delete params
    elsif params[:action] == "create"
      Message.perform_create params
    end
  end
end
