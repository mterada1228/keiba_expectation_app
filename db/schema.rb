# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_05_235728) do

  create_table "horse_race_results", id: false, force: :cascade do |t|
    t.integer "horse_id"
    t.string "race_result_id"
    t.integer "gate_num"
    t.integer "horse_number"
    t.float "odds"
    t.integer "popularity"
    t.string "rank"
    t.string "jockey"
    t.float "burden_weight"
    t.string "time"
    t.float "time_diff"
    t.string "passing_order"
    t.float "last_3f"
    t.integer "horse_weight"
    t.integer "difference_in_horse_weight"
    t.float "get_prize"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "horses", id: false, force: :cascade do |t|
    t.integer "id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "race_horses", id: false, force: :cascade do |t|
    t.string "race_id"
    t.string "horse_id"
    t.integer "gate_num"
    t.integer "horse_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "race_results", force: :cascade do |t|
    t.string "name"
    t.integer "course_id"
    t.integer "course_length"
    t.date "date"
    t.string "course_type"
    t.string "course_condition"
    t.string "entire_rap"
    t.float "ave_1F"
    t.float "first_half_ave_3F"
    t.float "last_half_ave_3"
    t.float "RPCI"
    t.float "prize"
    t.integer "horse_all_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "races", id: false, force: :cascade do |t|
    t.integer "id", null: false
    t.datetime "race_date"
    t.string "race_course"
    t.integer "round"
    t.string "race_name"
    t.string "grade"
    t.integer "course_type", default: 0
    t.integer "distance"
    t.integer "turn", default: 0
    t.integer "side", default: 0
    t.integer "days"
    t.string "regulation1"
    t.string "regulation2"
    t.string "regulation3"
    t.string "regulation4"
    t.float "prize1"
    t.float "prize2"
    t.float "prize3"
    t.float "prize4"
    t.float "prize5"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
