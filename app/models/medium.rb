# == Schema Information
#
# Table name: media
#
#  id              :bigint           not null, primary key
#  mediumable_type :string
#  type            :string
#  url             :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  mediumable_id   :bigint
#
# Indexes
#
#  index_media_on_mediumable  (mediumable_type,mediumable_id)
#
class Medium < ApplicationRecord
  validates :url, presence: true, if: :new_record?

  belongs_to :mediumable, polymorphic: true
  
  mount_uploader :url, ImageUploader
end
