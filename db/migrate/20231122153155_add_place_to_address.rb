class AddPlaceToAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :place, :string
  end
end
