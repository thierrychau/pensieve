class RemovePlaceFormattedFromAddress < ActiveRecord::Migration[7.0]
  def change
    remove_column :addresses, :place_formatted
  end
end
