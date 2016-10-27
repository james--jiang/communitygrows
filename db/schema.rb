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

ActiveRecord::Schema.define(version: 20161027034826) do

  create_table "announcements", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "committee_type"
  end

  create_table "calendars", force: :cascade do |t|
    t.string   "html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "announcement_id"
  end

  add_index "comments", ["announcement_id"], name: "index_comments_on_announcement_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "documents", force: :cascade do |t|
    t.string   "url"
    t.string   "title"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "committee_type"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "location"
    t.string   "description"
    t.datetime "date"
    t.string   "url"
    t.datetime "end"
  end

# Could not dump table "users" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

end
