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

ActiveRecord::Schema.define(version: 20151114052342) do

  create_table "game_actions", force: :cascade do |t|
    t.string   "name_jp",    limit: 255
    t.string   "name_en",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

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

  create_table "game_key_configs", force: :cascade do |t|
    t.integer  "game_platform_id", limit: 4
    t.integer  "game_info_id",     limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "name_jp",          limit: 255
  end

  add_index "game_key_configs", ["game_info_id"], name: "fk_rails_7351c05732", using: :btree
  add_index "game_key_configs", ["game_platform_id"], name: "fk_rails_4fcc60662f", using: :btree

  create_table "game_key_configs_keys", force: :cascade do |t|
    t.integer "game_key_config_id", limit: 4
    t.integer "game_key_id",        limit: 4
  end

  create_table "game_key_types", force: :cascade do |t|
    t.string   "name_en",          limit: 255
    t.string   "sign",             limit: 255
    t.integer  "game_platform_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "game_key_types", ["game_platform_id"], name: "fk_rails_21c793091f", using: :btree

  create_table "game_keys", force: :cascade do |t|
    t.integer  "game_key_type_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "game_action_id",   limit: 4
  end

  add_index "game_keys", ["game_action_id"], name: "fk_rails_e1f14ddc7c", using: :btree
  add_index "game_keys", ["game_key_type_id"], name: "fk_rails_102fee8291", using: :btree

  create_table "game_platforms", force: :cascade do |t|
    t.string   "name_en",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "task_categories", force: :cascade do |t|
    t.string   "name_jp",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "task_info_logs", force: :cascade do |t|
    t.string   "content",      limit: 255
    t.integer  "task_info_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "task_info_logs", ["task_info_id"], name: "fk_rails_693d52a443", using: :btree

  create_table "task_infos", force: :cascade do |t|
    t.string   "title",                      limit: 255
    t.string   "detail",                     limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "estimate_task_time_type_id", limit: 4
    t.integer  "task_status_id",             limit: 4
    t.integer  "task_category_id",           limit: 4
  end

  add_index "task_infos", ["task_category_id"], name: "fk_rails_39ed1f35e9", using: :btree
  add_index "task_infos", ["task_status_id"], name: "fk_rails_75d480a9ee", using: :btree

  create_table "task_statuses", force: :cascade do |t|
    t.string   "name_jp",       limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "view_priority", limit: 4
  end

  create_table "task_time_types", force: :cascade do |t|
    t.string   "name_jp",    limit: 255
    t.integer  "value",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "game_key_configs", "game_infos"
  add_foreign_key "game_key_configs", "game_platforms"
  add_foreign_key "game_key_types", "game_platforms"
  add_foreign_key "game_keys", "game_actions"
  add_foreign_key "game_keys", "game_key_types"
  add_foreign_key "task_info_logs", "task_infos"
  add_foreign_key "task_infos", "task_categories"
  add_foreign_key "task_infos", "task_statuses"
end
