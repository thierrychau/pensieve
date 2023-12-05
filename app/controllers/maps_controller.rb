class MapsController < ApplicationController
  def geojson
    data = {
      type: 'FeatureCollection',
      features: [
        {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [-45, 0]
          },
          properties: {
            title: 'Memory',
            description: 'A memory from this location.'
          }
        },
        # More features...
      ]
    }

    render json: data
  end
end
