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

ActiveRecord::Schema[7.0].define(version: 2022_10_25_180939) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.integer "reputation"
    t.string "identicon_url"
  end

  create_table "chips", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.string "gravatar_url"
    t.integer "so_id"
    t.integer "reputation"
    t.integer "gold"
    t.integer "silver"
    t.integer "bronze"
    t.datetime "reputation_updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "post_id", null: false
    t.text "body"
    t.integer "rank", default: 1666753978, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.string "title"
    t.string "title_slug"
    t.text "body"
    t.integer "votes"
    t.integer "views"
    t.boolean "accepted", default: false, null: false
    t.bigint "question_id"
    t.integer "rank", default: 1666753978, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["question_id"], name: "index_posts_on_question_id"
  end

  create_table "posts_tags", id: false, force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "tag_id", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  add_foreign_key "comments", "authors"
  add_foreign_key "comments", "posts"
  add_foreign_key "posts", "authors"
  add_foreign_key "posts", "posts", column: "question_id"
end
