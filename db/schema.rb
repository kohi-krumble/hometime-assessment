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

ActiveRecord::Schema[7.1].define(version: 2026_01_11_051319) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "start_at"
    t.date "end_at"
    t.integer "no_of_nights", default: 1, null: false
    t.string "status", default: "pending", null: false
    t.integer "payout_amount_cents", default: 0, null: false
    t.integer "security_amount_cents", default: 0, null: false
    t.integer "total_amount_cents", default: 0, null: false
    t.string "currency", default: "AUD", null: false
    t.jsonb "details", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency"], name: "index_reservations_on_currency"
    t.index ["end_at"], name: "index_reservations_on_end_at"
    t.index ["start_at"], name: "index_reservations_on_start_at"
    t.index ["status"], name: "index_reservations_on_status"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name"
    t.jsonb "phone_numbers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_type", default: "guest", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["user_type"], name: "index_users_on_user_type"
  end

  add_foreign_key "reservations", "users"
end
