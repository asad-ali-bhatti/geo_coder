require_relative '../application'

Application.config do |config|
  config.set :port, 9000
  config.set :google_api_key, 'AIzaSyB2sWd4ZzY7PqvoB7lLSxMOdFFSphWHMzE' #store keys in ENV
end