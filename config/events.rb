WebsocketRails::EventMap.describe do
  subscribe :send_message, 'messages#new'
  subscribe :result_update, 'messages#result'
end