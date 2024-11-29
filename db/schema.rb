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

ActiveRecord::Schema[7.2].define(version: 2024_11_28_032246) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "bag_content_tags", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "bag_content_uuid", null: false
    t.index ["bag_content_uuid"], name: "index_bag_content_tags_on_bag_content_uuid"
  end

  create_table "bag_contents", primary_key: "uuid", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "item_list_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_uuid", null: false
    t.index ["item_list_id"], name: "index_bag_contents_on_item_list_id"
    t.index ["user_uuid"], name: "index_bag_contents_on_user_uuid"
    t.index ["uuid"], name: "index_bag_contents_on_uuid", unique: true
  end

  create_table "default_items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_list_default_items", force: :cascade do |t|
    t.bigint "item_list_id", null: false
    t.bigint "default_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["default_item_id"], name: "index_item_list_default_items_on_default_item_id"
    t.index ["item_list_id"], name: "index_item_list_default_items_on_item_list_id"
  end

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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover_image"
    t.uuid "user_uuid", null: false
    t.index ["user_uuid"], name: "index_item_lists_on_user_uuid"
  end

  create_table "item_statuses", force: :cascade do |t|
    t.bigint "item_list_id", null: false
    t.bigint "original_item_id"
    t.bigint "default_item_id"
    t.boolean "is_checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "selected", default: false, null: false
    t.integer "quantity", default: 1, null: false
    t.index ["default_item_id"], name: "index_item_statuses_on_default_item_id"
    t.index ["item_list_id"], name: "index_item_statuses_on_item_list_id"
    t.index ["original_item_id"], name: "index_item_statuses_on_original_item_id"
  end

  create_table "original_items", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.uuid "user_uuid", null: false
    t.index ["user_uuid"], name: "index_original_items_on_user_uuid"
  end

  create_table "recommends", primary_key: "uuid", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "place", null: false
    t.string "item", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item_image"
    t.uuid "user_uuid", null: false
    t.index ["user_uuid"], name: "index_recommends_on_user_uuid"
    t.index ["uuid"], name: "index_recommends_on_uuid", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", primary_key: "uuid", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "avatar"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "bag_content_tags", "bag_contents", column: "bag_content_uuid", primary_key: "uuid"
  add_foreign_key "bag_content_tags", "tags"
  add_foreign_key "bag_contents", "item_lists"
  add_foreign_key "bag_contents", "users", column: "user_uuid", primary_key: "uuid"
  add_foreign_key "item_list_default_items", "default_items"
  add_foreign_key "item_list_default_items", "item_lists"
  add_foreign_key "item_list_original_items", "item_lists"
  add_foreign_key "item_list_original_items", "original_items"
  add_foreign_key "item_lists", "users", column: "user_uuid", primary_key: "uuid"
  add_foreign_key "item_statuses", "default_items"
  add_foreign_key "item_statuses", "item_lists"
  add_foreign_key "item_statuses", "original_items"
  add_foreign_key "original_items", "users", column: "user_uuid", primary_key: "uuid"
  add_foreign_key "recommends", "users", column: "user_uuid", primary_key: "uuid"
end
