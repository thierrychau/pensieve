# == Schema Information
#
# Table name: addresses
#
#  id           :bigint           not null, primary key
#  address      :string
#  country      :string
#  country_code :string
#  full_address :string
#  input        :string
#  lat          :decimal(12, 8)
#  lng          :decimal(12, 8)
#  place        :string
#  postcode     :string
#  region       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Address < ApplicationRecord
  has_many :memories

  after_create :fetch_coordinates_and_components

  ADDRESS_COMPONENTS_FIELDS = %i[country country_code full_address address postcode region].freeze

  def self.ransackable_attributes(auth_object = nil)
    [
      "input"
    ]
  end

private

  def fetch_coordinates_and_components
    if !ENV['MAPBOX_API_KEY'].nil?
      location_data = MapboxService.new(self.input).call
    end
    if location_data.present? 
      ADDRESS_COMPONENTS_FIELDS.each do |field|
        self.send("#{field}=", location_data[:address_components][field])
      end
      self.lat = location_data[:coordinates][0]
      self.lng = location_data[:coordinates][1]
      if self.save
        # Handle successful save
      else
        # Handle save errors
      end
    else
      # Handle missing location data
    end
  end
end
