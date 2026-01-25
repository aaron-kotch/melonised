require "uri"
require "net/http"
require "json"

class CoinGeckoClient
  BASE_URL = "https://api.coingecko.com/api/v3"

  def self.get_wallet(address)
    address = address.presence || "0xdac17f958d2ee523a2206206994597c13d831ec7"
    url = "#{BASE_URL}/onchain/networks/eth/tokens/#{address}/info"
    make_request(url)
  end

  def self.get_coins
    url = "#{BASE_URL}/coins/markets?vs_currency=usd"
    make_request(url)
  end

  def self.get_trending
    url = "#{BASE_URL}/search/trending"
    make_request(url)
  end

  private

  def self.make_request(url_string)
    url = URI(url_string)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["x-cg-demo-api-key"] = ENV["COINGECKO_API_KEY"]

    response = http.request(request)
    JSON.parse(response.read_body)
  rescue StandardError => e
    puts "CoinGecko API Error: #{e.message}"
    {}
  end
end
