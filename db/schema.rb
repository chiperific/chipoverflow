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

ActiveRecord::Schema[7.0].define(version: 2022_10_24_155946) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chips", force: :cascade do |t|
    t.string "name", default: "Chip Kragt"
    t.string "phone", default: "616.528.8140"
    t.string "address", default: "1001 Alexander St SE, Grand Rapids, MI 49507"
    t.string "gravatar_url", default: "https://www.gravatar.com/avatar/5c7a5fcd85529e17f9aa86c1e9a5490e?s=48&d=identicon&r=PG", null: false
    t.integer "so_id", default: 1880203, null: false
    t.integer "reputation"
    t.integer "gold"
    t.integer "silver"
    t.integer "bronze"
    t.datetime "reputation_updated_at"
  end

end
