module Geojsonable
  extend ActiveSupport::Concern

  class_methods do
    def to_geojson(memories)
      {
        type: "FeatureCollection",
        features: memories.map { |memory| memory_to_feature(memory) }
      }
    end

    def memory_to_feature(memory)
      {
        type: "Feature",
        geometry: {
          type: "Point",
          coordinates: [memory.lng, memory.lat]
        },
        properties: {
          id: memory.id,
          title: memory.title,
          description: memory.description,
          date: memory.date.strftime("%B %-d, %Y"),
          people: people_to_properties(memory.people)
        }
      }
    end

    def people_to_properties(people)
      people.map(&:firstlast_name).join(', ')
    end
  end
end
