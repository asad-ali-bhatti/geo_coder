require_relative '../lib/route'

Route.draw do |route|
  route.add controller: 'GeocoderController', action: 'code', method: 'POST'
end