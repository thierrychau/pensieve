class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :address
      t.string :full_address
      t.string :place_formatted
      t.string :country
      t.string :country_code_alpha_3
      t.string :region
      t.string :postcode
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
