class DropAddressTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :addresses
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
