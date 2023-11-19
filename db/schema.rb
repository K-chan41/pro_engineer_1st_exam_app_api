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

ActiveRecord::Schema[7.0].define(version: 2023_11_19_080820) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "access_token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_token"], name: "index_api_keys_on_access_token", unique: true
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "choices", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "content", null: false
    t.integer "order", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flags", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_flags_on_question_id"
    t.index ["user_id"], name: "index_flags_on_user_id"
  end

  create_table "labels", force: :cascade do |t|
    t.integer "number", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_category_relations", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_question_category_relations_on_category_id"
    t.index ["question_id"], name: "index_question_category_relations_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "subject_id", null: false
    t.bigint "label_id"
    t.integer "number", null: false
    t.text "content", null: false
    t.string "question_img_src"
    t.integer "correct_answer_no", null: false
    t.text "commentary", null: false
    t.string "answer_img_src"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_questions_on_label_id"
    t.index ["subject_id"], name: "index_questions_on_subject_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.integer "year", null: false
    t.integer "exam_subject", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_question_relations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.integer "answer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_user_question_relations_on_question_id"
    t.index ["user_id"], name: "index_user_question_relations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "api_keys", "users"
  add_foreign_key "choices", "questions"
  add_foreign_key "flags", "questions"
  add_foreign_key "flags", "users"
  add_foreign_key "question_category_relations", "categories"
  add_foreign_key "question_category_relations", "questions"
  add_foreign_key "questions", "labels"
  add_foreign_key "questions", "subjects"
  add_foreign_key "user_question_relations", "questions"
  add_foreign_key "user_question_relations", "users"
end
