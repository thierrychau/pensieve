# == Schema Information
#
# Table name: memories
#
#  id          :bigint           not null, primary key
#  date        :date
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  address_id  :bigint
#  author_id   :bigint           not null
#
# Indexes
#
#  index_memories_on_address_id  (address_id)
#  index_memories_on_author_id   (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#  fk_rails_...  (author_id => users.id)
#
class Memory < ApplicationRecord
  validates :date, :presence => true
  validates :author_id, :presence => true

  belongs_to :author, class_name: "User"
  belongs_to :address, optional: true
  has_many :people_memories, inverse_of: :memory
  has_many :people, through: :people_memories

  accepts_nested_attributes_for :people_memories
  accepts_nested_attributes_for :address, reject_if: :address_exists?

  scope :by_date, -> { order(date: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    [
      "description", "date", "location"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    [
      "author"
    ]
  end

  private

  def address_exists?(attributes)
    address_name = attributes['name']
    return false if address_name.blank?

    address = Address.find_or_create_by(name: address_name)
    update(address_id: address.id)
    # address.fetch_coordinates_and_components if address.persisted?
    true
  end
end
