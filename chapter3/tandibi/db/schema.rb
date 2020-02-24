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

ActiveRecord::Schema.define(version: 2020_02_24_224200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bonds", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "friend_id", null: false
    t.string "state", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "friend_id"], name: "index_bonds_on_user_id_and_friend_id", unique: true
  end

  create_table "pictures", force: :cascade do |t|
    t.string "caption"
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "thread_id"
    t.string "postable_type", null: false
    t.bigint "postable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["postable_type", "postable_id"], name: "index_posts_on_postable_type_and_postable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "first_name", null: false
    t.string "last_name"
    t.string "email", null: false
    t.boolean "is_public", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "bonds", "users"
  add_foreign_key "bonds", "users", column: "friend_id"
  add_foreign_key "pictures", "posts"
  add_foreign_key "posts", "posts", column: "thread_id"
  add_foreign_key "posts", "users"
end
