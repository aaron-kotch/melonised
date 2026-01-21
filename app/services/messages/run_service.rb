require "ostruct"

module Messages
  class RunService
    def self.call(raw_text, &block)
      new(raw_text).call(&block)
    end

    def initialize(raw_text)
      @raw_text = raw_text
    end

    def call(&block)
      chat = RubyLLM.chat(model: "claude-haiku-4-5")

      chat.with_tools(
        Tools::Wallet::SearchWallet,
        Tools::Wallet::GetCoins,
        Tools::Wallet::GetTrendings
      )

      # Ask a question
      chat.ask @raw_text do |chunk|
        if block_given? && chunk.content.present?
          block.call(chunk)
        end
      end
    end
  end
end
