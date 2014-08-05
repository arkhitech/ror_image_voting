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

ActiveRecord::Schema.define(version: 20140805143033) do

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "group_shares", force: true do |t|
    t.integer  "group_id"
    t.integer  "media_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_shares", ["group_id"], name: "index_group_shares_on_group_id"
  add_index "group_shares", ["media_id"], name: "index_group_shares_on_media_id"

  create_table "groups", force: true do |t|
    t.string   "group_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id"

  create_table "media", force: true do |t|
    t.string   "picture"
    t.string   "caption",       limit: 140
    t.boolean  "is_private"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_user_id"
  end

  add_index "media", ["admin_user_id"], name: "index_media_on_admin_user_id"
  add_index "media", ["user_id"], name: "index_media_on_user_id"

  create_table "members", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["group_id"], name: "index_members_on_group_id"
  add_index "members", ["user_id"], name: "index_members_on_user_id"

  create_table "slams", force: true do |t|
    t.integer  "media_id_first_id"
    t.integer  "media_id_second_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slams", ["media_id_first_id"], name: "index_slams_on_media_id_first_id"
  add_index "slams", ["media_id_second_id"], name: "index_slams_on_media_id_second_id"

  create_table "users", force: true do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "username"
    t.string   "profile_picture"
    t.string   "description",            limit: 140
    t.boolean  "is_private"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: true do |t|
    t.boolean  "vote_status"
    t.integer  "user_id_id"
    t.integer  "slam_id_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["slam_id_id"], name: "index_votes_on_slam_id_id"
  add_index "votes", ["user_id_id"], name: "index_votes_on_user_id_id"

end
