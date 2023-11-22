class RemoveFullAddressFromAddress < ActiveRecord::Migration[7.0]
  def change
    remove_column :addresses, :full_address
  end
end
