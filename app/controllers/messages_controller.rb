class MessagesController < WebsocketRails::BaseController
  def new
    broadcast_message :spread_message, message unless message[:msg].empty?
  end
end