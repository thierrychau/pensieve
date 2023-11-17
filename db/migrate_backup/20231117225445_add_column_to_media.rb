class AddColumnToMedia < ActiveRecord::Migration[7.0]
  def change
    add_reference :media, :memory, index: true
  end
end
