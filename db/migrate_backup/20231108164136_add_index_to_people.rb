class AddIndexToPeople < ActiveRecord::Migration[7.0]
  def change
    add_index :people, [:first_name, :last_name], unique: true
  end
end
