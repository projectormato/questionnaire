class MessagesController < WebsocketRails::BaseController
  include ActionView::Helpers::TextHelper
  include ERB::Util

  def result
    message[:msg].each do |k, v|
      unless v.empty?
        result = Result.create comment: v
        Tag.create name: k, result: result
        broadcast_message k + '_update', simple_format(h(v)) unless v.empty?
      end
    end
  end
end