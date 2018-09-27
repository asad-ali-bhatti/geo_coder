require 'json'

class ApplicationController
  def initialize
    self.default_response = {code: 200, headers: {'Content-Type' => 'application/json'}, body: ''}
  end

  def welcome(request)
    [200, {'Content-Type' => 'text/html'}, ['Welcome to geocoder']]
  end

  def response(options)
    # we can add response header according to logic
    resp = default_response.dup
    resp = resp.merge(options)
    [resp[:code], resp[:headers], [resp[:body]]]
  end

  private
  attr_accessor :default_response
end