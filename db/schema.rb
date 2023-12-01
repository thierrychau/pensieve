# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_01_001810) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "input"
    t.string "address"
    t.string "full_address"
    t.string "country"
    t.string "country_code"
    t.string "region"
    t.string "postcode"
    t.decimal "lat", precision: 12, scale: 8
    t.decimal "lng", precision: 12, scale: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "place"
  end

  create_table "media", force: :cascade do |t|
    t.string "url"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mediumable_type"
    t.bigint "mediumable_id"
    t.index ["mediumable_type", "mediumable_id"], name: "index_media_on_mediumable"
  end

  create_table "memories", force: :cascade do |t|
    t.date "date"
    t.string "title"
    t.text "description"
    t.bigint "address_id"
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_memories_on_address_id"
    t.index ["author_id"], name: "index_memories_on_author_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_of_birth"
    t.string "alternate_name"
    t.index ["first_name", "last_name"], name: "index_people_on_first_name_and_last_name", unique: true
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "people_memories", force: :cascade do |t|
    t.bigint "memory_id", null: false
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["memory_id"], name: "index_people_memories_on_memory_id"
    t.index ["person_id"], name: "index_people_memories_on_person_id"
  end

  create_table "users", force: :cascade do |t|
    t.citext "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.boolean "ai_generated_content", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "memories", "addresses"
  add_foreign_key "memories", "users", column: "author_id"
  add_foreign_key "people", "users"
  add_foreign_key "people_memories", "memories"
  add_foreign_key "people_memories", "people"
end
