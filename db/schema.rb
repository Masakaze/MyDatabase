# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151018084205) do

  create_table "game_genres", force: :cascade do |t|
    t.string   "name_jp",    limit: 255
    t.string   "name_en",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "game_genres_infos", force: :cascade do |t|
    t.integer "game_info_id",  limit: 4
    t.integer "game_genre_id", limit: 4
  end

  create_table "game_infos", force: :cascade do |t|
    t.string   "name_jp",    limit: 255
    t.string   "name_en",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "game_infos_game_genres", force: :cascade do |t|
    t.integer "game_info_id",  limit: 4
    t.integer "game_genre_id", limit: 4
  end

  create_table "game_infos_platforms", force: :cascade do |t|
    t.integer "game_info_id",     limit: 4
    t.integer "game_platform_id", limit: 4
  end

  create_table "game_key_types", force: :cascade do |t|
    t.string   "name_en",          limit: 255
    t.string   "sign",             limit: 255
    t.integer  "game_platform_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "game_key_types", ["game_platform_id"], name: "fk_rails_21c793091f", using: :btree

  create_table "game_platforms", force: :cascade do |t|
    t.string   "name_en",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "game_key_types", "game_platforms"
end
