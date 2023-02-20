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

ActiveRecord::Schema.define(version: 2023_02_20_112254) do

  create_table "cards", primary_key: "user_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "cus_id", null: false
    t.string "car_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chars", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "c_name", default: ""
    t.string "cause", default: ""
    t.integer "looks", default: 0
    t.integer "chara", default: 0
    t.integer "ablty", default: 0
    t.integer "str", default: 0
    t.integer "cute", default: 0
    t.integer "ero", default: 0
    t.integer "funny", default: 0
    t.integer "cool", default: 0
    t.bigint "path_id", default: 0
    t.bigint "ttl_id", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["path_id"], name: "index_chars_on_path_id"
    t.index ["ttl_id"], name: "index_chars_on_ttl_id"
  end

  create_table "cres", primary_key: "user_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "icon"
    t.string "hdr"
    t.string "twtr"
    t.string "pixiv"
    t.string "insta"
    t.string "yt"
    t.string "link"
  end

  create_table "crs", primary_key: "user_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bank"
    t.string "branch"
    t.string "a_type"
    t.integer "number"
    t.string "holder"
  end

  create_table "expls", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "adv_id"
    t.text "a_msg"
    t.timestamp "created_at"
  end

  create_table "expors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "e_img"
    t.timestamp "created_at"
    t.string "kind"
    t.string "hope"
    t.integer "fee", default: 0
    t.timestamp "updated_at"
    t.text "gist"
    t.bigint "msg_id"
    t.string "who"
    t.date "e_dl"
    t.string "cmt"
    t.string "w_st"
    t.string "cont"
    t.bigint "path_id"
    t.index ["msg_id"], name: "index_expors_on_msg_id"
    t.index ["path_id"], name: "index_expors_on_path_id"
    t.index ["user_id"], name: "index_expors_on_user_id"
  end

  create_table "ips", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "addr", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "msgs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.timestamp "created_at"
    t.text "s_msg"
  end

  create_table "ovrs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "expor_id"
    t.string "o_img"
    t.integer "up_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expor_id"], name: "index_ovrs_on_expor_id"
  end

  create_table "paths", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "url", default: ""
    t.string "img", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pfms", primary_key: "cre_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "pic", default: 0
    t.integer "dl", default: 100
    t.integer "reply", default: 100
    t.integer "point", default: 100
    t.integer "evl", default: 50
    t.integer "sales", default: 0
    t.integer "wdl", default: 0
  end

  create_table "reqs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "money"
    t.integer "tx_id"
    t.integer "rx_id"
    t.string "stts"
    t.string "fmt"
    t.boolean "nsfw", default: false
    t.boolean "anon", default: false
    t.boolean "auto", default: false
    t.text "msg"
    t.timestamp "created_at"
  end

  create_table "resms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "re_id"
    t.integer "noti_id"
  end

  create_table "sttgs", primary_key: "cre_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "recom", default: 5000
    t.integer "min", default: 1000
    t.integer "work_d", default: 14
    t.boolean "start", default: false
    t.boolean "nsfw", default: false
    t.string "job", default: "評論家"
  end

  create_table "ttls", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "t_name", default: ""
    t.string "genre", default: ""
    t.string "pub", default: ""
    t.boolean "com", default: true
    t.boolean "serial", default: true
    t.string "auth", default: ""
    t.bigint "path_id", default: 0
    t.timestamp "created_at"
    t.index ["path_id"], name: "index_ttls_on_path_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "agree", default: false, null: false
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

  create_table "works", primary_key: "req_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "d_time"
    t.boolean "in_time"
    t.boolean "rework", default: false
    t.timestamp "updated_at"
    t.json "images"
  end

end
