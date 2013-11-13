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

ActiveRecord::Schema.define(version: 20131113130958) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: true do |t|
    t.integer  "object_id"
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["object_id"], name: "index_assets_on_object_id", using: :btree

  create_table "locations", force: true do |t|
    t.string  "district"
    t.string  "address"
    t.string  "city"
    t.string  "state"
    t.integer "zip"
    t.string  "website"
    t.string  "location"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string  "location_type"
  end

  create_table "route_points", force: true do |t|
    t.integer  "object_id"
    t.datetime "posting_time"
    t.decimal  "x"
    t.decimal  "y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscribers", force: true do |t|
    t.string   "phone_number"
    t.string   "address"
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
