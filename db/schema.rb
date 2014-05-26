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

ActiveRecord::Schema.define(version: 20140526050226) do

  create_table "blog_articles", force: true do |t|
    t.string   "title"
    t.text     "article"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "tag_id"
    t.integer  "comments_count", default: 0
    t.integer  "read_count",     default: 0
  end

  create_table "comments", force: true do |t|
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "blog_article_id"
  end

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reply_to_id"
  end

  create_table "photos", force: true do |t|
    t.integer  "user_id"
    t.text     "intro"
    t.binary   "thumbnail"
    t.binary   "original"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "blog_articles_count", default: 0
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.string   "gender"
    t.string   "self_intro"
    t.integer  "popularity",          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blog_articles_count", default: 0
    t.integer  "tags_count",          default: 0
    t.binary   "photo"
    t.binary   "small_photo"
    t.integer  "photos_count",        default: 0
  end

end
