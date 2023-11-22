require "http"
require "json"

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

      if data['features'] && !data['features'].empty?
        first_feature = data['features'].first
        place_name = first_feature['place_name']
        address = first_feature['text']
        country = nil
        country_code_alpha_3 = nil
        full_address = nil
        postcode = nil
        region = nil
        place = nil

        # Define suffixes to handle variations in keys
        suffixes = {
          'postcode' => /postcode\.\d+/,
          'region' => /region\.\d+/,
          'place' => /place\.\d+/,
          'country' => /country\.\d+/
        }

        first_feature['context'].each do |context|
          suffixes.each do |key, regex|
            if context['id'] =~ regex
              case key
              when 'country'
                country = context['text']
                country_code_alpha_3 = context['short_code'].upcase if context.key?('short_code')
              when 'postcode'
                postcode = context['text']
              when 'region'
                region = context['text']
              when 'place'
                place = context['text']
              end
            end
          end
        end

      {
        coordinates: first_feature.dig('geometry', 'coordinates'),
        address_components: {
          country: country,
          country_code_alpha_3: country_code_alpha_3,
          full_address: first_feature['place_name'],
          address: first_feature.dig('text'),
          place: place,
          postcode: postcode,
          region: region
        }.transform_values(&:presence)
      }
      end

    rescue StandardError => e
      # Log the error
      Rails.logger.error("Error fetching Mapbox data: #{e.message}")
      nil
    end
  end
end
