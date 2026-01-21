RubyLLM.configure do |config|
  # config.openai_api_key = ENV['OPENAI_API_KEY'] || Rails.application.credentials.dig(:openai_api_key)
  # config.default_model = "gpt-4.1-nano"
  config.anthropic_api_key = ENV["ANTHROPIC_API_KEY"] || Rails.application.credentials.dig(:anthropic_api_key)

  # Use the new association-based acts_as API (recommended)
  config.use_new_acts_as = true
end
