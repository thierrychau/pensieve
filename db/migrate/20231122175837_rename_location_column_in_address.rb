class RenameLocationColumnInAddress < ActiveRecord::Migration[7.0]
  def change
    rename_column :addresses, :location, :input
  end
end
