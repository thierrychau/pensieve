class AddTitleToMemories < ActiveRecord::Migration[7.0]
  def change
    add_column :memories, :title, :string
  end
end
