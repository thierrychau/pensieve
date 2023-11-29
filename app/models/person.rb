# == Schema Information
#
# Table name: people
#
#  id             :bigint           not null, primary key
#  alternate_name :string
#  date_of_birth  :date
#  first_name     :string           not null
#  last_name      :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
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
  validates :user_id, :presence => true

  belongs_to :user
  
  has_many :people_memories
  has_many :memories, through: :people_memories
  has_many :media, as: :mediumable, dependent: :destroy
  
  before_save :titleize_name
  
  def firstlast_name
    "#{self.first_name} #{last_name}" 
  end
  
  private
    def titleize_name
      self.first_name = self.first_name.titleize
      self.last_name = self.last_name.titleize
    end

end
