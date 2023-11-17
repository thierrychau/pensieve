class ChangeColumnTypeInAddress < ActiveRecord::Migration[7.0]
  def change
    change_column :addresses, :lat, :decimal, precision: 12, scale: 8  
    change_column :addresses, :lng, :decimal, precision: 12, scale: 8  
  end
end
