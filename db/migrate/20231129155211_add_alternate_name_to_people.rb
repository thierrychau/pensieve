class AddAlternateNameToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :alternate_name, :string
  end
end
