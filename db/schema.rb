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

ActiveRecord::Schema.define(:version => 20121216020935) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "chapters", :force => true do |t|
    t.integer  "game_version_id"
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "position"
  end

  add_index "chapters", ["game_version_id"], :name => "index_chapters_on_game_version_id"
  add_index "chapters", ["position", "game_version_id"], :name => "index_chapters_on_position_and_game_version_id", :unique => true

  create_table "cities", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "enrollment_images", :force => true do |t|
    t.string   "image"
    t.integer  "mission_enrollment_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "enrollment_images", ["mission_enrollment_id"], :name => "index_enrollment_images_on_mission_enrollment_id"

  create_table "game_versions", :force => true do |t|
    t.string   "name"
    t.string   "language"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "game_versions", ["id"], :name => "index_game_versions_on_id", :unique => true
  add_index "game_versions", ["name"], :name => "index_game_versions_on_name", :unique => true

  create_table "mission_enrollments", :force => true do |t|
    t.integer  "mission_id"
    t.integer  "user_id"
    t.string   "url"
    t.string   "title"
    t.text     "description"
    t.text     "html_description"
    t.boolean  "accomplished",      :default => false
    t.text     "validation_params"
    t.datetime "last_checked_at"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "mission_enrollments", ["last_checked_at"], :name => "index_mission_enrollments_on_last_checked_at"
  add_index "mission_enrollments", ["mission_id"], :name => "index_mission_enrollments_on_mission_id"
  add_index "mission_enrollments", ["url"], :name => "index_mission_enrollments_on_url"
  add_index "mission_enrollments", ["user_id"], :name => "index_mission_enrollments_on_user_id"

  create_table "missions", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "description"
    t.text     "html_description"
    t.string   "element",           :default => ""
    t.integer  "position"
    t.string   "video_url"
    t.string   "image"
    t.string   "validation_class"
    t.text     "validation_params"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "chapter_id"
  end

  add_index "missions", ["chapter_id"], :name => "index_missions_on_chapter_id"
  add_index "missions", ["element"], :name => "index_missions_on_element"
  add_index "missions", ["slug"], :name => "index_missions_on_slug"

  create_table "oracles", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "facebook_link"
    t.string   "twitter_link"
    t.string   "google_plus_link"
    t.string   "instagram_link"
    t.text     "bio"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "nickname"
    t.string   "element",                :default => ""
    t.string   "avatar"
    t.string   "language"
    t.integer  "game_version_id"
    t.integer  "points",                 :default => 0
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.integer  "city_id"
    t.string   "name"
    t.string   "gender"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["element"], :name => "index_users_on_element"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["game_version_id"], :name => "index_users_on_game_version_id"
  add_index "users", ["provider", "uid"], :name => "index_users_on_provider_and_uid", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
