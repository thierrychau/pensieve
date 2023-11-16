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

  # before_save :memory_coordinates
  
  belongs_to :author, class_name: "User"
  belongs_to :address, optional: true
  has_many :people_memories
  has_many :people, through: :people_memories

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :people_memories

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

  def update_people(people_ids)
    PeopleMemory.where({ :memory_id => self.id }).destroy_all

    people_ids.each do |id|
      PeopleMemory.create({ :memory_id => self.id, :person_id => id })
    end
  end
end
