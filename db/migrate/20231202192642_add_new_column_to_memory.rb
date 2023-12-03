class AddNewColumnToMemory < ActiveRecord::Migration[7.0]
  def change
    add_column :memories, :lat, :decimal, precision: 12, scale: 8
    add_column :memories, :lng, :decimal, precision: 12, scale: 8
    add_column :memories, :place, :string
    add_column :memories, :country, :string
    add_column :memories, :location, :string
  end
end
