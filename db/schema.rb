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

ActiveRecord::Schema.define(version: 2020_09_18_000737) do

  create_table "horse_race_results", id: false, force: :cascade do |t|
    t.string "horse_id"
    t.string "race_result_id"
    t.string "gate_num"
    t.string "horse_number"
    t.string "odds"
    t.string "popularity"
    t.string "rank"
    t.string "jockey"
    t.string "burden_weight"
    t.string "time"
    t.string "time_diff"
    t.string "passing_order"
    t.string "last_3f"
    t.string "horse_weight"
    t.string "difference_in_horse_weight"
    t.string "get_prize"
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
    t.string "gate_num"
    t.string "horse_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "race_results", force: :cascade do |t|
    t.string "name"
    t.string "cource_id"
    t.string "cource_length"
    t.date "date"
    t.string "cource_type"
    t.string "cource_condition"
    t.string "entire_rap"
    t.float "ave_1F"
    t.float "first_half_ave_3F"
    t.float "last_half_ave_3"
    t.float "RPCI"
    t.string "prize"
    t.string "horse_all_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "races", id: false, force: :cascade do |t|
    t.integer "id", null: false
    t.string "race_date"
    t.string "race_cource"
    t.string "round"
    t.string "race_name"
    t.string "grade"
    t.string "start_time"
    t.string "cource_type"
    t.string "distance"
    t.string "turn"
    t.string "side"
    t.string "days"
    t.string "regulation1"
    t.string "regulation2"
    t.string "regulation3"
    t.string "regulation4"
    t.string "prize1"
    t.string "prize2"
    t.string "prize3"
    t.string "prize4"
    t.string "prize5"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
