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

ActiveRecord::Schema[8.0].define(version: 2024_12_19_001712) do
  create_table "exercise_schedules", force: :cascade do |t|
    t.integer "train_schedule_id", null: false
    t.integer "exercise_id", null: false
    t.string "day_of_week"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercise_schedules_on_exercise_id"
    t.index ["train_schedule_id"], name: "index_exercise_schedules_on_train_schedule_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "link"
    t.string "name"
    t.string "muscle_group"
    t.string "exercise_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "progresses", force: :cascade do |t|
    t.integer "exercise_id", null: false
    t.integer "user_id", null: false
    t.date "date"
    t.string "type"
    t.integer "reps"
    t.decimal "weight"
    t.decimal "duration"
    t.decimal "intensity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_progresses_on_exercise_id"
    t.index ["user_id"], name: "index_progresses_on_user_id"
  end

  create_table "train_schedules", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_train_schedules_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.integer "weight"
    t.integer "height"
    t.date "birth_day"
    t.string "goal"
    t.string "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "exercise_schedules", "exercises"
  add_foreign_key "exercise_schedules", "train_schedules"
  add_foreign_key "progresses", "exercises"
  add_foreign_key "progresses", "users"
  add_foreign_key "train_schedules", "users"
end
