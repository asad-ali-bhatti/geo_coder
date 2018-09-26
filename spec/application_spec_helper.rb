Dir[File.join('./lib', '**/*.rb')].each {|f| require f}
Dir[File.join('./config', '**/*.rb')].each {|f| require f}
require_relative 'helper_classes'
# lib_files = File.expand_path('../lib/**/*.rb', __FILE__)
# Dir.glob(lib_files).each { |file| require(file) }
