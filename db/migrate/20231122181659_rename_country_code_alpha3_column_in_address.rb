class RenameCountryCodeAlpha3ColumnInAddress < ActiveRecord::Migration[7.0]
  def change
    rename_column :addresses, :country_code_alpha_3, :country_code
  end
end
