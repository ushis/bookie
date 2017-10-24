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

ActiveRecord::Schema.define(version: 20171015125449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avatars", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.json "image_meta_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_avatars_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn", null: false
    t.string "title"
    t.string "authors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authors"], name: "index_books_on_authors"
    t.index ["isbn"], name: "index_books_on_isbn", unique: true
    t.index ["title"], name: "index_books_on_title"
  end

  create_table "comments", force: :cascade do |t|
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.bigint "author_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  end

  create_table "copies", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id", "owner_id"], name: "index_copies_on_book_id_and_owner_id", unique: true
    t.index ["book_id"], name: "index_copies_on_book_id"
    t.index ["owner_id"], name: "index_copies_on_owner_id"
  end

  create_table "covers", force: :cascade do |t|
    t.string "isbn", null: false
    t.json "image_meta_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["isbn"], name: "index_covers_on_isbn", unique: true
  end

  create_table "friendship_requests", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.string "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id", "state"], name: "index_friendship_requests_on_receiver_id_and_state"
    t.index ["receiver_id"], name: "index_friendship_requests_on_receiver_id"
    t.index ["sender_id", "receiver_id"], name: "index_friendship_requests_on_sender_id_and_receiver_id", unique: true
    t.index ["sender_id", "state"], name: "index_friendship_requests_on_sender_id_and_state"
    t.index ["sender_id"], name: "index_friendship_requests_on_sender_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "friend_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.json "auth_meta_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
