# == Schema Information
#
# Table name: memories
#
#  id          :bigint           not null, primary key
#  date        :date
#  description :text
#  latitude    :decimal(, )
#  location    :string
#  longitude   :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :bigint           not null
#
# Indexes
#
#  index_memories_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#
class Memory < ApplicationRecord
  validates :date, :presence => true
  validates :author_id, :presence => true

  before_save :memory_coordinates
  
  belongs_to :author, class_name: "User"
  has_many :people_memories
  has_many :people, through: :people_memories

  scope :by_date, -> { order(date: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    [
      "description"
    ]
  end

  def memory_coordinates
    geocoding_service = GeocodingService.new(self.location)
    coordinates = geocoding_service.call

    if coordinates
      self.latitude = coordinates.fetch(:latitude)
      self.longitude = coordinates.fetch(:longitude)
    end
  end
end
