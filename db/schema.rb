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

ActiveRecord::Schema.define(version: 20131110173311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "destinations", force: true do |t|
    t.integer  "destination_strategy_id"
    t.string   "destination_strategy_type"
    t.boolean  "enabled",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imports", force: true do |t|
    t.integer  "photo_id"
    t.integer  "source_id"
    t.text     "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "photo_uid"
    t.string   "title"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",       default: false
    t.string   "url"
    t.string   "small_photo_uid"
  end

  create_table "postings", force: true do |t|
    t.integer  "photo_id"
    t.integer  "destination_id"
    t.text     "response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services_dropboxes", force: true do |t|
    t.integer  "uid"
    t.string   "token"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services_facebook_pages", force: true do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services_facebooks", force: true do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services_wordpresses", force: true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "host"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", force: true do |t|
    t.integer  "source_strategy_id"
    t.string   "source_strategy_type"
    t.boolean  "enabled",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
