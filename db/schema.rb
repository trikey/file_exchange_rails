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

ActiveRecord::Schema.define(version: 20160505154452) do

  create_table "files", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255, default: "null"
    t.string   "path",        limit: 255
    t.integer  "folder_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "files", ["folder_id"], name: "index_files_on_folder_id", using: :btree

  create_table "folders", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255, default: "null"
    t.integer  "parent_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "folders", ["parent_id"], name: "index_folders_on_parent_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "fio",              limit: 255
    t.string   "email",            limit: 255
    t.string   "password",         limit: 255
    t.string   "organisation",     limit: 255
    t.integer  "isAdmin",          limit: 4
    t.integer  "unsigned_integer", limit: 4
    t.integer  "isModerator",      limit: 4
    t.integer  "canAccess",        limit: 4
    t.string   "rememberToken",    limit: 255
    t.string   "salt",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
