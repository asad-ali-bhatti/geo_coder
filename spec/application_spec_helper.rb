Dir[File.join('./lib', '**/*.rb')].each {|f| require f}
# lib_files = File.expand_path('../lib/**/*.rb', __FILE__)
# Dir.glob(lib_files).each { |file| require(file) }
