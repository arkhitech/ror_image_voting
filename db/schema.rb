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

ActiveRecord::Schema.define(version: 20140812112210) do

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

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "followers", force: true do |t|
    t.integer  "user_id"
    t.integer  "follower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followers", ["follower_id"], name: "index_followers_on_follower_id"
  add_index "followers", ["user_id"], name: "index_followers_on_user_id"

  create_table "group_shares", force: true do |t|
    t.integer  "user_group_id"
    t.integer  "medium_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_shares", ["medium_id"], name: "index_group_shares_on_medium_id"
  add_index "group_shares", ["user_group_id"], name: "index_group_shares_on_user_group_id"

  create_table "media", force: true do |t|
    t.string   "picture"
    t.string   "caption",          limit: 140
    t.boolean  "is_private"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_user_id"
    t.integer  "slams_count"
    t.integer  "slammables_count"
  end

  add_index "media", ["admin_user_id"], name: "index_media_on_admin_user_id"
  add_index "media", ["user_id"], name: "index_media_on_user_id"

  create_table "members", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["user_group_id"], name: "index_members_on_user_group_id"
  add_index "members", ["user_id"], name: "index_members_on_user_id"

  create_table "slams", force: true do |t|
    t.integer  "medium_first_id"
    t.integer  "medium_second_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slams", ["medium_first_id"], name: "index_slams_on_medium_first_id"
  add_index "slams", ["medium_second_id"], name: "index_slams_on_medium_second_id"

  create_table "user_groups", force: true do |t|
    t.string   "group_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_groups", ["user_id"], name: "index_user_groups_on_user_id"

  create_table "user_votes", force: true do |t|
    t.boolean  "vote_status"
    t.integer  "user_id"
    t.integer  "slam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_votes", ["slam_id"], name: "index_user_votes_on_slam_id"
  add_index "user_votes", ["user_id"], name: "index_user_votes_on_user_id"

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
    t.string   "provider"
    t.string   "uid"
    t.string   "authentication_token"
    t.integer  "media_count"
    t.integer  "followers_count"
    t.integer  "following_count"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
