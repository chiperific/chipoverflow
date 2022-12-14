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

ActiveRecord::Schema[7.0].define(version: 2022_11_05_153616) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "plain_text_body"
    t.index "to_tsvector('english'::regconfig, plain_text_body)", name: "tsvector_body_idx", using: :gin
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.integer "reputation", default: 0, null: false
    t.integer "gold", default: 0, null: false
    t.integer "silver", default: 0, null: false
    t.integer "bronze", default: 0, null: false
    t.string "gravatar_url"
  end

  create_table "chips", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.string "gravatar_url"
    t.integer "so_id", default: 0, null: false
    t.integer "reputation", default: 0, null: false
    t.integer "gold", default: 0, null: false
    t.integer "silver", default: 0, null: false
    t.integer "bronze", default: 0, null: false
    t.datetime "reputation_updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "post_id", null: false
    t.integer "votes", default: 0, null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_at"
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["votes"], name: "index_comments_on_votes"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.string "title"
    t.string "title_slug", default: "", null: false
    t.text "body"
    t.integer "votes", default: 0, null: false
    t.integer "views", default: 0, null: false
    t.boolean "accepted", default: false, null: false
    t.bigint "question_id"
    t.integer "rank", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_at"
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["question_id"], name: "index_posts_on_question_id"
    t.index ["rank"], name: "index_posts_on_rank"
    t.index ["votes"], name: "index_posts_on_votes"
  end

  create_table "posts_tags", id: false, force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "tag_id", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "score", default: 0, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "authors"
  add_foreign_key "comments", "posts"
  add_foreign_key "posts", "authors"
  add_foreign_key "posts", "posts", column: "question_id"
end
