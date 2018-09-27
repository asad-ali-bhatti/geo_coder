Dir[File.join('./config', '**/*.rb')].each {|f| require f}
Dir[File.join('./lib', '**/*.rb')].each {|f| require f}

use Rack::Reloader, 0
Rack::Handler::WEBrick.run GeoCoder.new, Port: Application.settings[:port]
