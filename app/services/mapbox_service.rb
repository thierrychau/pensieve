require "http"
require "json"

class MapboxService
  MAPBOX_ACCESS_TOKEN = ENV["MAPBOX_API_KEY"].freeze

  def self.fetch_data(name)
    response = RestClient.get("https://api.mapbox.com/geocoding/v5/mapbox.places/#{URI.encode(name)}.json?access_token=#{MAPBOX_ACCESS_TOKEN}")
    data = JSON.parse(response.body)

    return nil unless data['features'].present?

    first_feature = data['features'].first
    coordinates = first_feature['geometry']['coordinates']

    address_components = {
      country: first_feature.dig('context', -1, 'text'),
      country_code_alpha_3: first_feature.dig('context', -1, 'short_code'),
      full_address: first_feature['place_name'],
      address: first_feature.dig('text'),
      place_formatted: first_feature.dig('place_type', 0),
      postcode: first_feature.dig('context', -2, 'text'),
      region: first_feature.dig('context', -2, 'text')
    }

    {
      coordinates: coordinates,
      address_components: address_components.transform_values(&:presence) # Remove nil values
    }
  rescue RestClient::ExceptionWithResponse => e
    # Handle API request errors
    puts "Error: #{e.response}"
    nil
  rescue StandardError => e
    # Handle other exceptions
    puts "Error: #{e.message}"
    nil
  end
end
