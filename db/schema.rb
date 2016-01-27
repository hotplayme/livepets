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

ActiveRecord::Schema.define(version: 20160125045731) do

  create_table "articles", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.text     "body",                limit: 65535
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "randid",              limit: 255
    t.integer  "views",               limit: 4,     default: 0
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "file",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "attachable_id",   limit: 4
    t.string   "attachable_type", limit: 255
  end

  add_index "attachments", ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type", using: :btree

  create_table "authorizations", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "authorizations", ["user_id"], name: "index_authorizations_on_user_id", using: :btree

  create_table "blog_attachments", force: :cascade do |t|
    t.string   "file",       limit: 255
    t.boolean  "main",       limit: 1
    t.integer  "blog_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title",                  limit: 255
    t.text     "body",                   limit: 65535
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.integer  "user_id",                limit: 4
    t.boolean  "del",                    limit: 1,     default: false
    t.boolean  "approve",                limit: 1,     default: false
    t.integer  "blog_attachments_count", limit: 4,     default: 0
    t.boolean  "payed",                  limit: 1,     default: false
    t.string   "comment",                limit: 255,   default: "на проверке"
  end

  create_table "breeds", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "breed_type",          limit: 255
    t.string   "translate",           limit: 255
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "country_id", limit: 4
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body",             limit: 65535
    t.integer  "user_id",          limit: 4
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "approve",          limit: 1,     default: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type", limit: 255
    t.integer  "impressionable_id",   limit: 4
    t.integer  "user_id",             limit: 4
    t.string   "controller_name",     limit: 255
    t.string   "action_name",         limit: 255
    t.string   "view_name",           limit: 255
    t.string   "request_hash",        limit: 255
    t.string   "ip_address",          limit: 255
    t.string   "session_hash",        limit: 255
    t.text     "message",             limit: 65535
    t.text     "referrer",            limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: {"impressionable_type"=>nil, "message"=>255, "impressionable_id"=>nil}, using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "mypets", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "user_id",               limit: 4
    t.integer  "breed_id",              limit: 4
    t.integer  "sex",                   limit: 4
    t.string   "photo_file_name",       limit: 255
    t.string   "photo_content_type",    limit: 255
    t.integer  "photo_file_size",       limit: 4
    t.datetime "photo_updated_at"
    t.date     "birthday"
    t.boolean  "approve",               limit: 1,   default: false
    t.boolean  "block",                 limit: 1,   default: false
    t.integer  "pet_attachments_count", limit: 4,   default: 0
  end

  add_index "mypets", ["breed_id"], name: "index_mypets_on_breed_id", using: :btree
  add_index "mypets", ["user_id"], name: "index_mypets_on_user_id", using: :btree

  create_table "pet_attachments", force: :cascade do |t|
    t.string   "file",       limit: 255
    t.boolean  "main",       limit: 1
    t.integer  "mypet_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text     "body",       limit: 65535
    t.integer  "user_id",    limit: 4
    t.integer  "topic_id",   limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "approve",    limit: 1,     default: false
  end

  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "review_attachments", force: :cascade do |t|
    t.integer  "review_id",  limit: 4
    t.string   "file",       limit: 255
    t.boolean  "main",       limit: 1,   default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "breed_id",       limit: 4
    t.integer  "views",          limit: 4
    t.integer  "comments_count", limit: 4
    t.integer  "votes_count",    limit: 4
    t.text     "body",           limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "title",          limit: 255
  end

  add_index "reviews", ["breed_id"], name: "index_reviews_on_breed_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "subscribes", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "subscriber_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "subscribes", ["subscriber_id"], name: "index_subscribes_on_subscriber_id", using: :btree
  add_index "subscribes", ["user_id"], name: "index_subscribes_on_user_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "views",      limit: 4,     default: 0
    t.boolean  "approve",    limit: 1,     default: false
  end

  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.string   "nickname",               limit: 255
    t.boolean  "admin",                  limit: 1,   default: false
    t.integer  "city_id",                limit: 4
    t.boolean  "approve",                limit: 1,   default: false
    t.boolean  "block",                  limit: 1,   default: false
    t.boolean  "bot",                    limit: 1,   default: false
    t.float    "repa",                   limit: 24,  default: 0.0
    t.float    "repa_total",             limit: 24,  default: 0.0
    t.datetime "nickname_updated_at"
    t.integer  "country_id",             limit: 4
    t.boolean  "writer",                 limit: 1,   default: false
    t.integer  "balance",                limit: 4,   default: 0
    t.string   "purse",                  limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["nickname"], name: "index_users_on_nickname", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "votable_id",   limit: 4
    t.string   "votable_type", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "score",        limit: 4
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree
  add_index "votes", ["votable_id", "votable_type"], name: "index_votes_on_votable_id_and_votable_type", using: :btree

  create_table "winners", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "score",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
