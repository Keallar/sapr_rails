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

ActiveRecord::Schema[7.0].define(version: 2022_12_20_184806) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "constructions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "left_support", default: false
    t.boolean "right_support", default: false
  end

  create_table "rods", force: :cascade do |t|
    t.integer "place_id"
    t.float "l"
    t.float "a"
    t.float "e"
    t.float "b"
    t.float "f"
    t.float "q"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "construction_id"
    t.float "u", default: [], array: true
    t.float "n", default: [], array: true
    t.float "s", default: [], array: true
    t.float "delta_0"
    t.float "delta_l"
    t.index ["construction_id"], name: "index_rods_on_construction_id"
  end

  add_foreign_key "rods", "constructions"
end
