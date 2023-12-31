# == Schema Information
#
# Table name: people_memories
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  memory_id  :bigint           not null
#  person_id  :bigint           not null
#
# Indexes
#
#  index_people_memories_on_memory_id  (memory_id)
#  index_people_memories_on_person_id  (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (memory_id => memories.id)
#  fk_rails_...  (person_id => people.id)
#
class PeopleMemory < ApplicationRecord
  # Represents a join table between people and memories.
  # PeopleMemories have a person and a memory.
  # PeopleMemories can be searched using their person or memory.
 
  validates :person_id, presence: true

  # associations
  ## direct associations
  belongs_to :memory, inverse_of: :people_memories
  belongs_to :person
end
