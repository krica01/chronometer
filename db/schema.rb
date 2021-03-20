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

ActiveRecord::Schema.define(version: 2021_03_20_113310) do

  create_table "race_permissions", force: :cascade do |t|
    t.integer "race_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "racers", force: :cascade do |t|
    t.integer "race_id"
    t.integer "number"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.datetime "race_time"
    t.string "race_time_string"
    t.index ["race_id"], name: "index_racers_on_race_id"
  end

  create_table "races", force: :cascade do |t|
    t.string "name"
    t.string "place"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "rz_records", force: :cascade do |t|
    t.integer "rz_id"
    t.integer "racer_id"
    t.datetime "startTime"
    t.datetime "finishTime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "reported"
    t.boolean "finished"
    t.string "rz_time_string"
    t.integer "race_id"
    t.datetime "field_name"
    t.datetime "rz_time"
    t.string "rzTimeString"
    t.index ["racer_id"], name: "index_rz_records_on_racer_id"
    t.index ["rz_id"], name: "index_rz_records_on_rz_id"
  end

  create_table "rzs", force: :cascade do |t|
    t.integer "race_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["race_id"], name: "index_rzs_on_race_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
