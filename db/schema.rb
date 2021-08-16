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

ActiveRecord::Schema.define(version: 2021_07_11_045848) do

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "horse_id", null: false
    t.string "race_id", null: false
    t.text "description", null: false
    t.string "user_name"
    t.integer "comment_type", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["horse_id"], name: "fk_rails_8e4f45009f"
    t.index ["race_id"], name: "fk_rails_b15decb6e5"
  end

  create_table "horse_races", primary_key: ["horse_id", "race_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "horse_id", null: false
    t.string "race_id", null: false
    t.integer "gate_number"
    t.integer "horse_number"
    t.float "odds"
    t.integer "popularity"
    t.integer "order_of_arrival"
    t.string "jockey"
    t.float "burden_weight", null: false
    t.time "time", precision: 3
    t.float "time_diff"
    t.string "passing_order"
    t.float "last_3f"
    t.integer "horse_weight"
    t.integer "difference_in_horse_weight"
    t.float "get_prize"
    t.integer "reason_of_exclusion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["horse_id"], name: "index_horse_races_on_horse_id"
    t.index ["race_id"], name: "index_horse_races_on_race_id"
  end

  create_table "horses", id: :bigint, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "race_prizes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "race_id"
    t.integer "order_of_arrival"
    t.integer "prize"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["race_id"], name: "index_race_prizes_on_race_id"
  end

  create_table "race_regulations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "race_id"
    t.integer "regulation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["race_id"], name: "index_race_regulations_on_race_id"
  end

  create_table "races", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "start", null: false
    t.integer "course", null: false
    t.integer "round", null: false
    t.string "name", null: false
    t.integer "grade"
    t.integer "course_type", null: false
    t.integer "distance", null: false
    t.integer "turn"
    t.integer "side"
    t.integer "day_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "has_result", default: false, null: false
    t.integer "course_condition"
    t.string "entire_rap"
    t.float "ave_1F"
    t.float "first_half_ave_3F"
    t.float "last_half_ave_3F"
    t.float "RPCI"
    t.integer "horse_all_number"
  end

  add_foreign_key "comments", "horses"
  add_foreign_key "comments", "races"
  add_foreign_key "horse_races", "horses"
end
