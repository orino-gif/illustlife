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

ActiveRecord::Schema.define(version: 2022_11_20_141730) do

  create_table "cards", primary_key: "user_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "cus_id", null: false
    t.string "car_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "creators", primary_key: "user_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "icon"
    t.string "hdr"
    t.string "twtr"
    t.string "pixiv"
    t.string "insta"
    t.string "yt"
    t.string "link"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "credits", primary_key: "user_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bank"
    t.string "branch"
    t.string "a_type"
    t.integer "number"
    t.string "holder"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "explanations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "adviser_id"
    t.text "letter_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exposures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "cntri_id"
    t.string "expo_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "performances", primary_key: "creator_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "pic", default: 0
    t.float "dl", default: 100.0
    t.float "reply", default: 100.0
    t.integer "point", default: 100
    t.integer "eval", default: 50
    t.integer "sales", default: 0
    t.integer "wdl", default: 0
  end

  create_table "requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "money"
    t.integer "tx_id"
    t.integer "rx_id"
    t.string "stts"
    t.string "fmt"
    t.boolean "nsfw", default: false
    t.boolean "anon", default: false
    t.boolean "auto", default: false
    t.datetime "created_at", null: false
    t.text "msg"
  end

  create_table "resumes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "re_id"
    t.integer "noti_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", primary_key: "creator_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "recom", default: 5000
    t.integer "min", default: 1000
    t.integer "work_d", default: 14
    t.boolean "start", default: false
    t.boolean "nsfw", default: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "agree", default: true, null: false
    t.string "nick", default: "", null: false
    t.string "provider", default: "", null: false
    t.string "uid", default: "", null: false
    t.datetime "soft_destroyed_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email", "provider", "uid", "soft_destroyed_at"], name: "index_users_on_email_and_provider_and_uid_and_soft_destroyed_at"
    t.index ["nick"], name: "index_users_on_nick"
  end

  create_table "works", primary_key: "request_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "d_time"
    t.boolean "in_time", default: false
    t.boolean "rework", default: false
    t.timestamp "updated_at"
    t.json "images"
  end

end
