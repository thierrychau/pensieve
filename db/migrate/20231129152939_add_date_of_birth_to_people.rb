class AddDateOfBirthToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :date_of_birth, :date
  end
end
