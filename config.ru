require './lib/geocoder'
require './config/initialize'

use Rack::Reloader, 0
Rack::Handler::WEBrick.run GeoCoder.new, Port: Application.settings[:port]
