class ChangeColumnTypeInMedia < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :media, :memories, column: :memory_id
  end
end
