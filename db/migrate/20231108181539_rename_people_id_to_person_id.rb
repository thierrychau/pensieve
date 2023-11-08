class RenamePeopleIdToPersonId < ActiveRecord::Migration[7.0]
  def change
    rename_column :people_memories, :people_id, :person_id
  end
end
