require "http"

class MapboxService
  MAPBOX_ACCESS_TOKEN = ENV["MAPBOX_API_KEY"].freeze

  def initialize(location)
    @location = location
  end

  def call
    begin
      response = HTTP.get("https://api.mapbox.com/geocoding/v5/mapbox.places/#{CGI.escape(@location)}.json?access_token=#{MAPBOX_ACCESS_TOKEN}")
      return nil unless response.code == 200

      data = JSON.parse(response.body)
      return nil unless data['features'].present?

      first_feature = data['features'].first

      {
        coordinates: first_feature.dig('geometry', 'coordinates'),
        address_components: {
          country: first_feature.dig('context', -1, 'text'),
          country_code_alpha_3: first_feature.dig('context', -1, 'short_code'),
          full_address: first_feature['place_name'],
          address: first_feature.dig('text'),
          place_formatted: first_feature.dig('place_type', 0),
          postcode: first_feature.dig('context', -2, 'text'),
          region: first_feature.dig('context', -2, 'text')
        }.transform_values(&:presence)
      }
    rescue StandardError => e
      # Log the error or handle it accordingly
      Rails.logger.error("Error fetching Mapbox data: #{e.message}")
      nil
    end
  end
end
