require "http"
require "json"

class GeocodingService
  def initialize(location)
    @location = location
  end

  def call
    raw_response = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{CGI.escape(@location)}&key=#{ENV["GMAPS_KEY"]}")
    parsed_response = JSON.parse(raw_response)

    if parsed_response["status"] == "OK"
      results = parsed_response["results"].at(0)
      geometry = results.fetch("geometry")
      location = geometry.fetch("location")
      
      {
        :latitude => location.fetch("lat"),
        :longitude => location.fetch("lng")
      }
    else
      nil
    end
  end
end
