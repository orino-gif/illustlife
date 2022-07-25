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

ActiveRecord::Schema.define(version: 2022_07_23_051652) do

  create_table "cards", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "INTEGER PRIMARY KEY NOT NULL"
    t.string "customer_id", null: false
    t.string "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "creators", primary_key: "user_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "icon"
    t.string "header"
    t.string "twitter"
    t.string "pixiv"
    t.string "instagram"
    t.string "youtube"
    t.string "link"
    t.integer "recommended_amount", default: 5000
    t.integer "minimum_amount", default: 1000
    t.integer "working_days", default: 14
    t.integer "number_of_request", default: 0
    t.integer "number_of_approval", default: 0
    t.integer "number_of_works", default: 0
    t.float "average_delivery_time", default: 0.0
    t.float "deadline_strict_adherence_rate", default: 100.0
    t.float "reply_rate", default: 100.0
    t.boolean "request_acceptance_permission", default: false
    t.integer "creator_points", default: 0
    t.integer "evaluation_points", default: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "nsfw", default: false
    t.integer "earnings", default: 0
    t.integer "withdrawal_amount", default: 0
  end

  create_table "credits", primary_key: "user_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bank"
    t.string "branch_name"
    t.string "account_type"
    t.integer "account_number"
    t.string "account_holder"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "money"
    t.integer "sender_id"
    t.integer "receiver_id"
    t.string "status"
    t.text "message"
    t.string "file_format"
    t.text "sender_icon_url"
    t.text "receiver_icon_url"
    t.boolean "is_nsfw", default: false
    t.boolean "is_anonymous", default: false
    t.boolean "is_autographed", default: false
    t.datetime "approval_day"
    t.integer "delivery_time", default: 0
    t.integer "is_in_time_for_the_deadline", default: 0
    t.string "deliver_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resumes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "resume_user"
    t.integer "notification_user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "accepted", default: false, null: false
    t.string "nickname", default: "", null: false
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
    t.index ["nickname"], name: "index_users_on_nickname"
  end

end
