class ChangeMediaToPolymorphic < ActiveRecord::Migration[7.0]
  def change
    remove_reference :media, :memory, index: true
    add_reference :media, :mediumable, polymorphic: true, index: true
  end
end
