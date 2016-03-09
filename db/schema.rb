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

ActiveRecord::Schema.define(version: 20160309030236) do

  create_table "article_attachments", force: :cascade do |t|
    t.string   "file",       limit: 255
    t.integer  "article_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

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

  create_table "articles_tags", id: false, force: :cascade do |t|
    t.integer "article_id", limit: 4
    t.integer "tag_id",     limit: 4
  end

  add_index "articles_tags", ["article_id"], name: "index_articles_tags_on_article_id", using: :btree
  add_index "articles_tags", ["tag_id"], name: "index_articles_tags_on_tag_id", using: :btree

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
    t.integer  "cost",                   limit: 4,     default: 0
    t.integer  "body_size",              limit: 4
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

  create_table "dialogs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dialogs_users", force: :cascade do |t|
    t.integer "dialog_id", limit: 4
    t.integer "user_id",   limit: 4
  end

  add_index "dialogs_users", ["dialog_id"], name: "index_dialogs_users_on_dialog_id", using: :btree
  add_index "dialogs_users", ["user_id"], name: "index_dialogs_users_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "body",       limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "dialog_id",  limit: 4
    t.string   "state",      limit: 255, default: "new"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

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

  create_table "notices", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "noticeable_id",   limit: 4
    t.string   "noticeable_type", limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.text     "body",            limit: 65535
    t.boolean  "new",             limit: 1,     default: true
    t.integer  "cid",             limit: 4
    t.boolean  "add",             limit: 1,     default: true
  end

  add_index "notices", ["noticeable_id", "noticeable_type"], name: "index_notices_on_noticeable_id_and_noticeable_type", using: :btree
  add_index "notices", ["user_id"], name: "index_notices_on_user_id", using: :btree

  create_table "pet_attachments", force: :cascade do |t|
    t.string   "file",       limit: 255
    t.boolean  "main",       limit: 1,   default: false
    t.integer  "mypet_id",   limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "user_id",    limit: 4
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
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "title",          limit: 255
    t.string   "breed_type",     limit: 255
    t.boolean  "del",            limit: 1,     default: false
  end

  add_index "reviews", ["breed_id"], name: "index_reviews_on_breed_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "subscribers", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "subscribable_id",   limit: 4
    t.string   "subscribable_type", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "subscribers", ["subscribable_id", "subscribable_type"], name: "index_subscribers_on_subscribable_id_and_subscribable_type", using: :btree
  add_index "subscribers", ["user_id"], name: "index_subscribers_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "views",      limit: 4,     default: 0
    t.boolean  "approve",    limit: 1,     default: false
    t.boolean  "attach",     limit: 1,     default: false
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
    t.integer  "my_feed_count",          limit: 4,   default: 0
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
