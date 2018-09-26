require_relative '../application'
require_relative 'route'

require 'bundler'
Bundler.require(:default)

class GeoCoder < Application
  def call(env)
    super
    request = Rack::Request.new(env)
    process_request(request)
  end

  def process_request(request)
    Route.new(request).process_request
  end
end