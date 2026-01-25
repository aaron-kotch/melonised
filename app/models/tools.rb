class Tools
  module Wallet
    class SearchWallet < RubyLLM::Tool
      description "Get crypto wallet details. Triggers the wallet view on the left panel."

      params do
        string :address, description: "The wallet address to search for. Optional."
      end

      def execute(address: nil)
        Turbo::StreamsChannel.broadcast_append_to(
          "chat_messages",
          target: "message_content",
          html: "<script>document.getElementById('btn-wallet').click();</script>"
        )
        CoinGeckoClient.get_wallet(address).to_json
      end
    end

    class GetCoins < RubyLLM::Tool
      description "Get the current list of supported coins and their prices. Triggers the coins view."

      def execute
        Turbo::StreamsChannel.broadcast_append_to(
          "chat_messages",
          target: "message_content",
          html: "<script>document.getElementById('btn-coins').click();</script>"
        )
        CoinGeckoClient.get_coins.to_json
      end
    end

    class GetTrendings < RubyLLM::Tool
      description "Get the current trending crypto coins. Triggers the trending view."

      def execute
        Turbo::StreamsChannel.broadcast_append_to(
          "chat_messages",
          target: "message_content",
          html: "<script>document.getElementById('btn-trending').click();</script>"
        )
        CoinGeckoClient.get_trending.to_json
      end
    end
  end
end
