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

ActiveRecord::Schema.define(version: 2022_10_31_142059) do

  create_table "cards", primary_key: "user_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
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
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "credits", primary_key: "user_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bank"
    t.string "branch"
    t.string "account_type"
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
    t.integer "contributor_id"
    t.string "exposed_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "idea_img"
    t.string "idea_img2"
    t.string "idea_img3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "performances", primary_key: "creator_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "painting", default: 0
    t.float "deadline", default: 100.0
    t.float "reply", default: 100.0
    t.integer "points", default: 100
    t.integer "evaluation", default: 50
    t.integer "earnings", default: 0
    t.integer "withdrawal", default: 0
  end

  create_table "requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "money"
    t.integer "sender_id"
    t.integer "receiver_id"
    t.string "status"
    t.text "message"
    t.string "file_format"
    t.boolean "is_nsfw", default: false
    t.boolean "is_anonymous", default: false
    t.boolean "is_autographed", default: false
    t.datetime "approval_day"
    t.integer "delivery_time", default: 0
    t.integer "is_in_time_for_the_deadline", default: 0
    t.string "deliver_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "deliver_img2"
    t.string "deliver_img3"
    t.string "deliver_img4"
    t.string "deliver_img5"
    t.string "deliver_img6"
    t.boolean "is_reworked", default: false
    t.text "evaluation_comment"
  end

  create_table "resumes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "resume_user"
    t.integer "notification_user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", primary_key: "creator_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "recommend", default: 5000
    t.integer "minimum", default: 1000
    t.integer "working", default: 14
    t.boolean "opening", default: false
    t.boolean "nsfw", default: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "accepted", default: true, null: false
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
