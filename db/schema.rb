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

ActiveRecord::Schema.define(version: 2020_08_11_124504) do

  create_table "hose_race_results", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "hose_id"
    t.string "race_id"
    t.string "gate_num"
    t.string "hose_num"
    t.string "odds"
    t.string "popularity"
    t.string "rank"
    t.string "jockey"
    t.string "burden_weight"
    t.string "time"
    t.string "time_diff"
    t.string "passing_order"
    t.string "last_3f"
    t.string "hose_weight"
    t.string "hose_weight_diff"
    t.string "get_prize"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hoses", primary_key: "hose_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
