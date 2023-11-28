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
  validates :author_id, :presence => true
  validates :description, :presence => true

  belongs_to :author, class_name: "User"
  belongs_to :address, optional: true

  has_many :people_memories, inverse_of: :memory, dependent: :destroy
  has_many :people, through: :people_memories
  has_many :media, inverse_of: :memory, dependent: :destroy

  accepts_nested_attributes_for :people_memories, allow_destroy: true
  accepts_nested_attributes_for :address, reject_if: :address_exists?
  accepts_nested_attributes_for :media, reject_if: :all_blank, allow_destroy: true

  scope :by_date, -> { order(date: :desc) }

  before_save :set_title

  private

    def set_title
      if self.title.blank? && !ENV['OPENAI_KEY'].nil?
        system_message = "You are a multilingual assistant. You will respond to the user's message with a title consisting of 7 to 25 words, ideally 20 words. Your response should be in the same language as the user's message."
        self.title = OpenAiService.new(self.description, system_message).call
      end
    end    

    def self.ransackable_attributes(auth_object = nil)
      [
        "description", "date",
      ]
    end

    def self.ransackable_associations(auth_object = nil)
      [
        "author", "address"
      ]
    end

    def address_exists?(attributes)
      address_name = attributes['input'].titleize
      return false if address_name.blank?

      address = Address.find_or_create_by(input: address_name)
      update(address_id: address.id)
      true
    end
end
