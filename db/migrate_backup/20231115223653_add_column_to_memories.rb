class AddColumnToMemories < ActiveRecord::Migration[7.0]
  def change
    add_reference :memories, :address, foreign_key: true
  end
end
