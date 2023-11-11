class LocationsController < ApplicationController
  def create
    @location = Location.new
    @location.name = params.fetch("name")

    geocoding_service = GeocodingService.new(@location.name)
    coordinates = geocoding_service.call

    if coordinates
      @location.latitude = coordinates.fetch(:latitude)
      @location.longitude = coordinates.fetch(:longitude)
      @location.save
    end

    render({ :template => "locations/show" })  
  end
end
