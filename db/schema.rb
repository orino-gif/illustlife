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

ActiveRecord::Schema.define(version: 2021_09_08_155548) do

  create_table "creators", primary_key: "user_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "icon"
    t.string "header"
    t.string "twitter"
    t.string "pixiv"
    t.string "sample"
    t.string "deforume1"
    t.string "deforume2"
    t.string "deforume3"
    t.string "background1"
    t.string "background2"
    t.string "background3"
    t.string "foreground1"
    t.string "foreground2"
    t.string "foreground3"
    t.string "bustup1"
    t.string "bustup2"
    t.string "bustup3"
    t.string "rough1"
    t.string "rough2"
    t.string "rough3"
    t.string "slide1"
    t.string "slide2"
    t.string "slide3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deforume_display", default: true
    t.boolean "background_display", default: true
    t.boolean "foreground_display", default: true
    t.boolean "bustup_display", default: true
    t.boolean "rough_display", default: true
    t.boolean "slide_display", default: true
  end

  create_table "requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "money"
    t.integer "send_id"
    t.integer "receive_id"
    t.string "status"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
