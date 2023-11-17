class RenameNameInAddress < ActiveRecord::Migration[7.0]
  def change
    rename_column :addresses, :name, :location
  end
end
