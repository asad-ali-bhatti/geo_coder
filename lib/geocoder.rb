require_relative '../application'

class GeoCoder < Application
  def call(env)
    request = Rack::Request(env)
    process_request(request)
    super
  end

  def process_request(request)

  end
end