# == Schema Information
#
# Table name: memories
#
#  id          :bigint           not null, primary key
#  country     :string
#  date        :date
#  description :text
#  lat         :decimal(12, 8)
#  lng         :decimal(12, 8)
#  location    :string
#  place       :string
#  title       :string
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
  # The Memory class represents a memory in the application.
  # It is associated with an author, people, and media.
  # Memories have attributes such as description, title, place, country, location, and date.
  # The title of a memory is automatically set using a multilingual assistant if it is blank and the OPENAI_KEY environment variable is present.
  # Memories can be searched using various attributes and associations.
  include Ransackable, Openaiable

  validates :author_id, presence: true
  validates :description, presence: true

  # associations
  ## direct associations
  belongs_to :author, class_name: "User"
  has_many :people_memories, inverse_of: :memory, dependent: :destroy
  has_many :media, as: :mediumable, dependent: :destroy

  ## indirect associations
  has_many :people, through: :people_memories

  # nested attributes
  accepts_nested_attributes_for :people_memories, allow_destroy: true
  accepts_nested_attributes_for :media, reject_if: :all_blank, allow_destroy: true

  scope :by_date, -> { order(date: :desc) }

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
