require_relative '../application'

Application.config do |config|
  config.set :port, 9000
  config.set :google_api_key, ENV['GOOGLE_API_KEY'] #store keys in ENV
end