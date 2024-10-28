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

ActiveRecord::Schema[7.2].define(version: 2024_10_28_144447) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "item_list_original_items", force: :cascade do |t|
    t.bigint "item_list_id", null: false
    t.bigint "original_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_list_id"], name: "index_item_list_original_items_on_item_list_id"
    t.index ["original_item_id"], name: "index_item_list_original_items_on_original_item_id"
  end

  create_table "item_lists", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_item_lists_on_name", unique: true
    t.index ["user_id"], name: "index_item_lists_on_user_id"
  end

  create_table "original_items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_list_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.integer "quantity"
    t.index ["item_list_id"], name: "index_original_items_on_item_list_id"
    t.index ["user_id"], name: "index_original_items_on_user_id"
  end

  create_table "recommends", force: :cascade do |t|
    t.string "place", null: false
    t.string "item", null: false
    t.text "body"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item_image"
    t.index ["user_id"], name: "index_recommends_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "item_list_original_items", "item_lists"
  add_foreign_key "item_list_original_items", "original_items"
  add_foreign_key "item_lists", "users"
  add_foreign_key "original_items", "item_lists"
  add_foreign_key "original_items", "users"
  add_foreign_key "recommends", "users"
end
