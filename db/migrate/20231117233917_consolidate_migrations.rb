class ConsolidateMigrations < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :location
      t.string :address
      t.string :full_address
      t.string :place_formatted
      t.string :country
      t.string :country_code_alpha_3
      t.string :region
      t.string :postcode
      t.decimal :lat, precision: 12, scale: 8
      t.decimal :lng, precision: 12, scale: 8

      t.timestamps
    end

    create_table :memories do |t|
      t.date :date
      t.string :title
      t.text :description
      t.references :address, optional: true, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    create_table :people do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.references :user, optional: true, foreign_key: true

      t.timestamps
    end

    add_index :people, [:first_name, :last_name], unique: true

    create_table :people_memories do |t|
      t.references :memory, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end

    create_table :media do |t|
      t.string :url
      t.string :type
      t.references :memory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
