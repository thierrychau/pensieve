class ChangeDecimalColumnsInAddresses < ActiveRecord::Migration[7.0]
  def change
    reversible do |change|
      change.up do
        change_column :addresses, :lat, :decimal, precision: 10, scale: 8, using: 'lat::numeric'
        change_column :addresses, :lng, :decimal, precision: 11, scale: 8, using: 'lng::numeric'
      end

      change.down do
        change_column :addresses, :lat, :float
        change_column :addresses, :lng, :float
      end
    end
  end
end
