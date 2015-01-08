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

ActiveRecord::Schema.define(version: 20150108013441) do

  create_table "cat_rental_requests", force: true do |t|
    t.integer  "cat_id"
    t.date     "start_date",                     null: false
    t.date     "end_date",                       null: false
    t.string   "status",     default: "PENDING", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "renter_id"
  end

  add_index "cat_rental_requests", ["cat_id"], name: "index_cat_rental_requests_on_cat_id"

  create_table "cats", force: true do |t|
    t.date     "birth_date",  null: false
    t.string   "color",       null: false
    t.string   "name",        null: false
    t.string   "sex",         null: false
    t.string   "image_url",   null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "user_tokens", force: true do |t|
    t.integer  "user_id",       null: false
    t.string   "session_token", null: false
    t.string   "device_info"
    t.string   "ip_address"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "user_tokens", ["session_token"], name: "index_user_tokens_on_session_token"
  add_index "user_tokens", ["user_id"], name: "index_user_tokens_on_user_id"

  create_table "users", force: true do |t|
    t.string   "user_name",       null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
