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

ActiveRecord::Schema.define(version: 2019_06_08_120253) do

  create_table "courses", force: :cascade do |t|
    t.string "tiss_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tiss_id"], name: "index_courses_on_tiss_id"
  end

  create_table "courses_users", id: false, force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "user_id", null: false
  end

  create_table "people", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tiss_id"
    t.index ["tiss_id"], name: "index_people_on_tiss_id"
  end

  create_table "people_users", id: false, force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "user_id", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "tiss_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tiss_id"], name: "index_projects_on_tiss_id"
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "user_id", null: false
  end

  create_table "theses", force: :cascade do |t|
    t.string "tiss_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tiss_id"], name: "index_theses_on_tiss_id"
  end

  create_table "theses_users", id: false, force: :cascade do |t|
    t.integer "thesis_id", null: false
    t.integer "user_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
