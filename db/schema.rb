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

ActiveRecord::Schema[7.1].define(version: 2024_01_02_223535) do
  create_table "boards", force: :cascade do |t|
    t.text "email"
    t.integer "width"
    t.integer "height"
    t.integer "mine_count"
    t.text "name"
    t.datetime "created" # TODO: Can remove because of auto gen rails created/updated at cols
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rows", force: :cascade do |t|
    t.integer "board_id", null: false
    t.integer "row_index"
    t.integer "col_index"
    t.text "row_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_rows_on_board_id"
  end

  add_foreign_key "rows", "boards"
end
