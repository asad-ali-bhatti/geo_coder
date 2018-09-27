require_relative 'application_controller'
require 'net/http'

class GeocoderController < ApplicationController
  def code(request)
    location = request.params['location']

    coordinates = get_geocode location
    if coordinates.keys.any?
      response({code: 200, body: coordinates.to_json })
    else
      response({code: 200, body: {error: 'Connection failed with google api'}.to_json})
    end
  end

  private

  def get_geocode(location)
    key = Application.settings[:google_api_key]
    google_api_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{key}"
    res = JSON.parse Net::HTTP.get(URI google_api_url)
    p res
    if res['status'] == 'OK'
      coordinates = res['results'][0]['geometry']['location']
    else
      coordinates = {}
    end
    coordinates
  end
end