# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_people_on_first_name_and_last_name  (first_name,last_name) UNIQUE
#  index_people_on_user_id                   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Person < ApplicationRecord
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :first_name, uniqueness: { scope: :last_name }

  before_save :capitalize_name

  belongs_to :user, optional: true
  has_many :people_memories
  has_many :memories, through: :people_memories

  def capitalize_name
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
  end

  def firstlast_name
    "#{self.first_name} #{last_name}" 
  end
end
