# == Schema Information
#
# Table name: media
#
#  id              :bigint           not null, primary key
#  media_url       :string
#  mediumable_type :string
#  type            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  mediumable_id   :bigint
#
# Indexes
#
#  index_media_on_mediumable  (mediumable_type,mediumable_id)
#
class Medium < ApplicationRecord
  # Represents a medium, such as an image or video, associated with another model.

  validates :media_url, presence: true, if: :new_record?

  # associations
  ## direct associations
  belongs_to :mediumable, polymorphic: true
  
  # to do: add validations for image and video types
  mount_uploader :media_url, ImageUploader # not needed? to remove later
end
