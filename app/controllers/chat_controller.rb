class ChatController < ApplicationController

  def create
    full_response = ""

    # Broadcast User Message
    Turbo::StreamsChannel.broadcast_append_to(
      "chat_messages",
      target: "message_content",
      html: render_to_string(partial: "chat/bubble/user", locals: { content: params[:content] })
    )

    # Broadcast Bot Container
    bot_message_id = "bot_message_#{SecureRandom.hex(4)}"
    Turbo::StreamsChannel.broadcast_append_to(
      "chat_messages",
      target: "message_content",
      html: render_to_string(partial: "chat/bubble/bot", locals: { id: bot_message_id })
    )

    Messages::RunService.call(params[:content]) do |chunk|
      full_response << chunk.content

      Turbo::StreamsChannel.broadcast_append_to(
        "chat_messages",
        target: bot_message_id,
        html: CGI.escapeHTML(chunk.content)
      )
    end

    puts "Full response: #{full_response.inspect}"

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_index_path }
    end
  end

  def get_wallet
    data = CoinGeckoClient.get_wallet(params[:address])
    puts "Wallet data: #{data.as_json}"

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "wallet_content",
          partial: "chat/wallet/wallet",
          locals: { data: data }
        )
      end
      format.html { redirect_to chat_index_path }
    end
  end

  def get_coins
    data = CoinGeckoClient.get_coins

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "wallet_content",
          partial: "chat/wallet/coins",
          locals: { data: data }
        )
      end
      format.html { redirect_to chat_index_path }
    end
  end

  def get_trending
    data = CoinGeckoClient.get_trending

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "wallet_content",
          partial: "chat/wallet/trending",
          locals: { data: data }
        )
      end
      format.html { redirect_to chat_index_path }
    end
  end
end
