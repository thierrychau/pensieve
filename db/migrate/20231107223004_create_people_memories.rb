class CreatePeopleMemories < ActiveRecord::Migration[7.0]
  def change
    create_table :people_memories do |t|
      t.references :memory, null: false, foreign_key: true
      t.references :people, null: false, foreign_key: true

      t.timestamps
    end
  end
end
