class MessagesController < WebsocketRails::BaseController
  include ActionView::Helpers::TextHelper
  include ERB::Util

  def result
    flg = message[:msg].select{|k, v| !v.empty?}.each do |k, v|
      result = Result.create comment: v
      Tag.create name: k, result: result
      broadcast_message k + '_update', simple_format(h(v))
    end.empty?

    send_message :notice, '送信しました' unless flg
  end
end