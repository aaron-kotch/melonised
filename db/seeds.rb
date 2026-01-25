# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Loading LLM models..."
RubyLLM.models.load_from_json!
Model.save_to_database
puts "Models loaded."

User.find_or_create_by!(email_address: "aaronssikua@gmail.com") do |user|
  user.password = "Psyduck@2049"
end
