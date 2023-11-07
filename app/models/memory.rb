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
  belongs_to :author, class_name: "User"
end
