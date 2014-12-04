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

ActiveRecord::Schema.define(version: 20141204111421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "hstore"

  create_table "z_document_infos", force: true do |t|
    t.string   "label"
    t.string   "revision"
    t.string   "type"
    t.string   "format_identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "z_formats", force: true do |t|
    t.string   "description"
    t.string   "mime_type"
    t.text     "accepted_extensions", default: [], array: true
    t.boolean  "default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "z_histories", force: true do |t|
    t.datetime "history_date"
    t.uuid     "z_item_id"
    t.integer  "revision"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "z_histories", ["z_item_id"], name: "index_z_histories_on_z_item_id", using: :btree

  create_table "z_item_infos", force: true do |t|
    t.string   "label"
    t.string   "identifier"
    t.string   "revision"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "z_items", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "label"
    t.hstore   "custom_attributes"
    t.text     "tags",              default: [], array: true
    t.integer  "revision"
    t.string   "format_identifier"
    t.string   "mime_type"
    t.uuid     "z_item_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resource_uri"
  end

  add_index "z_items", ["z_item_id"], name: "index_z_items_on_z_item_id", using: :btree

end
