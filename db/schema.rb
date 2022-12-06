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

ActiveRecord::Schema[7.0].define(version: 2022_12_06_002744) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_restaurants", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_restaurants_on_event_id"
    t.index ["restaurant_id"], name: "index_event_restaurants_on_restaurant_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "event_name"
    t.datetime "datetime"
    t.integer "price_min"
    t.integer "price_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "cuisines", default: [], array: true
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "restaurant_picks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.bigint "event_restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_restaurant_picks_on_event_id"
    t.index ["event_restaurant_id"], name: "index_restaurant_picks_on_event_restaurant_id"
    t.index ["user_id"], name: "index_restaurant_picks_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "cuisine"
    t.string "phone_number"
    t.string "image_url"
    t.integer "ave_price"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.string "open_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "event_restaurants", "events"
  add_foreign_key "event_restaurants", "restaurants"
  add_foreign_key "events", "users"
  add_foreign_key "restaurant_picks", "event_restaurants"
  add_foreign_key "restaurant_picks", "events"
  add_foreign_key "restaurant_picks", "users"
end
