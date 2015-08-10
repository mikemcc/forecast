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

ActiveRecord::Schema.define(version: 20150810035630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "user_id",                null: false
    t.integer  "vendor_id",              null: false
    t.integer  "sheet_id",               null: false
    t.integer  "version",    default: 0
    t.integer  "january",    default: 0
    t.integer  "february",   default: 0
    t.integer  "march",      default: 0
    t.integer  "april",      default: 0
    t.integer  "may",        default: 0
    t.integer  "june",       default: 0
    t.integer  "july",       default: 0
    t.integer  "august",     default: 0
    t.integer  "september",  default: 0
    t.integer  "october",    default: 0
    t.integer  "november",   default: 0
    t.integer  "december",   default: 0
    t.string   "signature"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "items_vendors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payloads", force: :cascade do |t|
    t.text     "contents"
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sheets", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "version",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendors", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
