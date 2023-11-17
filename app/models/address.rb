# == Schema Information
#
# Table name: addresses
#
#  id                   :bigint           not null, primary key
#  address              :string
#  country              :string
#  country_code_alpha_3 :string
#  full_address         :string
#  lat                  :decimal(10, 8)
#  lng                  :decimal(11, 8)
#  location             :string
#  place_formatted      :string
#  postcode             :string
#  region               :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Address < ApplicationRecord
  has_many :memories

  # after_create :fetch_coordinates_and_components

  ADDRESS_COMPONENTS_FIELDS = %i[country country_code_alpha_3 full_address address place_formatted postcode region].freeze

  def fetch_coordinates_and_components
    return if lat.present? && lng.present? && name.present? # Skip if coordinates and name are already present

    data = MapboxService.fetch_data(address)

    if data.present?
      update_coordinates(data[:coordinates]) if data[:coordinates].present?
      update_address_components(data[:address_components]) if data[:address_components].present?
    else
      # Handle the case where data couldn't be fetched
      # Maybe log an error or handle it in your application's way
    end
  end

  private

  def update_coordinates(coordinates)
    update(lat: coordinates[1], lng: coordinates[0])
  end

  def update_address_components(address_components)
    ADDRESS_COMPONENTS_FIELDS.each do |field|
      update(field => address_components[field]) if address_components.key?(field)
    end
  end
end
