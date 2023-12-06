class DropMediaTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :media
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
