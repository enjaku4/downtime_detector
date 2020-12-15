# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_15_115016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "problems", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "web_address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["web_address_id"], name: "index_problems_on_web_address_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "password_hash", null: false
    t.string "password_salt", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
  end

  create_table "users_web_addresses", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "web_address_id"
    t.index ["user_id"], name: "index_users_web_addresses_on_user_id"
    t.index ["web_address_id"], name: "index_users_web_addresses_on_web_address_id"
  end

  create_table "web_addresses", force: :cascade do |t|
    t.integer "http_status_code"
    t.datetime "pinged_at"
    t.string "url", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "notification_sent", default: false, null: false
    t.index ["url"], name: "index_web_addresses_on_url", unique: true
  end

  add_foreign_key "problems", "web_addresses"
end
