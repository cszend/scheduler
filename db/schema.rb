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

ActiveRecord::Schema.define(version: 20140330231433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "offices", force: true do |t|
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "hours"
    t.text     "description"
    t.string   "category"
    t.integer  "listed"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "time_zone"
  end

  add_index "offices", ["category"], name: "index_offices_on_category", using: :btree
  add_index "offices", ["id"], name: "index_offices_on_id", unique: true, using: :btree
  add_index "offices", ["listed", "status"], name: "index_offices_on_listed_and_status", using: :btree

  create_table "providers", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.integer  "role"
    t.integer  "access"
    t.string   "password_digest"
    t.integer  "office_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "providers", ["email"], name: "index_providers_on_email", unique: true, using: :btree
  add_index "providers", ["office_id", "role"], name: "index_providers_on_office_id_and_role", using: :btree
  add_index "providers", ["remember_token"], name: "index_providers_on_remember_token", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
