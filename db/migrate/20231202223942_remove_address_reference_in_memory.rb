class RemoveAddressReferenceInMemory < ActiveRecord::Migration[7.0]
  def change
    remove_reference :memories, :address, foreign_key: true
  end
end
