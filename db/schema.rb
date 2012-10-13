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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121013110949) do

  create_table "decks", :force => true do |t|
    t.string   "url"
    t.string   "title"
    t.string   "author"
    t.integer  "width"
    t.integer  "height"
    t.integer  "user_id"
    t.text     "html"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "decks", ["url"], :name => "index_decks_on_url"
  add_index "decks", ["user_id"], :name => "index_decks_on_user_id"

  create_table "narrations", :force => true do |t|
    t.integer  "deck_id"
    t.integer  "state"
    t.text     "time_code"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "wav_file_name"
    t.string   "wav_content_type"
    t.integer  "wav_file_size"
    t.datetime "wav_updated_at"
    t.string   "mp3_file_name"
    t.string   "mp3_content_type"
    t.integer  "mp3_file_size"
    t.datetime "mp3_updated_at"
  end

  add_index "narrations", ["deck_id", "state"], :name => "index_narrations_on_deck_id_and_state"

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "profile_image_url"
  end

  add_index "users", ["uid"], :name => "index_users_on_uid"

end
