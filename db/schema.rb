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

ActiveRecord::Schema.define(version: 2018_03_11_105900) do

  create_table "checks", force: :cascade do |t|
    t.string "description"
    t.string "check_type"
    t.integer "trigger_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trigger_id"], name: "index_checks_on_trigger_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "triggers", force: :cascade do |t|
    t.string "description"
    t.string "target"
    t.string "action"
    t.integer "repository_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_triggers_on_repository_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "display_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "variables", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.integer "check_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_id"], name: "index_variables_on_check_id"
  end

end
