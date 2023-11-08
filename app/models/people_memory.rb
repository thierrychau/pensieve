# == Schema Information
#
# Table name: people_memories
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  memory_id  :bigint           not null
#  people_id  :bigint           not null
#
# Indexes
#
#  index_people_memories_on_memory_id  (memory_id)
#  index_people_memories_on_people_id  (people_id)
#
# Foreign Keys
#
#  fk_rails_...  (memory_id => memories.id)
#  fk_rails_...  (people_id => people.id)
#
class PeopleMemory < ApplicationRecord
  validates :memory_id, :presence => true
  validates :people_id, :presence => true

  belongs_to :memory
  belongs_to :people
end
