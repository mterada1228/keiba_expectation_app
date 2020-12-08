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

ActiveRecord::Schema.define(version: 2020_12_17_052118) do

  create_table "horse_race_results", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "horse_id"
    t.string "race_result_id"
    t.integer "gate_number"
    t.integer "horse_number"
    t.float "odds"
    t.integer "popularity"
    t.string "order_of_arrival", null: false
    t.string "jockey"
    t.float "burden_weight", null: false
    t.string "time"
    t.float "time_diff"
    t.string "passing_order"
    t.float "last_3f"
    t.integer "horse_weight"
    t.integer "difference_in_horse_weight"
    t.float "get_prize"
    t.integer "reason_of_exclusion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["horse_id"], name: "fk_rails_330d59a0fb"
    t.index ["race_result_id"], name: "fk_rails_a076ec7130"
  end

  create_table "horses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "race_horses", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "race_id"
    t.string "horse_id"
    t.integer "gate_number"
    t.integer "horse_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "race_results", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "course_id", null: false
    t.integer "course_length", null: false
    t.date "date", null: false
    t.integer "course_type", null: false
    t.integer "course_condition", null: false
    t.string "entire_rap"
    t.float "ave_1F"
    t.float "first_half_ave_3F"
    t.float "last_half_ave_3F"
    t.float "RPCI"
    t.float "prize"
    t.integer "horse_all_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "races", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "start", null: false
    t.string "course", null: false
    t.integer "round", null: false
    t.string "name", null: false
    t.string "grade"
    t.integer "course_type", null: false
    t.integer "distance", null: false
    t.integer "turn", null: false
    t.integer "side"
    t.integer "day_number"
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

  add_foreign_key "horse_race_results", "horses"
  add_foreign_key "horse_race_results", "race_results"
end
