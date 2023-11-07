class CreateMemories < ActiveRecord::Migration[7.0]
  def change
    create_table :memories do |t|
      t.date :date
      t.string :location
      t.decimal :latitude
      t.decimal :longitude
      t.text :description
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
