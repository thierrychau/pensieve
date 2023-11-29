# == Schema Information
#
# Table name: media
#
#  id         :bigint           not null, primary key
#  type       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  memory_id  :bigint           not null
#
# Indexes
#
#  index_media_on_memory_id  (memory_id)
#
# Foreign Keys
#
#  fk_rails_...  (memory_id => memories.id)
#
class Medium < ApplicationRecord
  validates :url, presence: true, if: :new_record?

  belongs_to :memory, inverse_of: :media
  
  mount_uploader :url, ImageUploader
end
