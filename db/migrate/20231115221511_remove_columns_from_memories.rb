class RemoveColumnsFromMemories < ActiveRecord::Migration[7.0]
  def change
    remove_column :memories, :location, :string
    remove_column :memories, :latitude, :decimal
    remove_column :memories, :longitude, :decimal
  end
end
