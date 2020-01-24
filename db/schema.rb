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

ActiveRecord::Schema.define(version: 2020_01_16_172702) do

  create_table "books", force: :cascade do |t|
    t.string "author_first_name"
    t.string "author_last_name"
    t.string "college_ids"
    t.string "uc_department"
    t.string "work_title"
    t.string "other_title"
    t.string "publisher"
    t.string "city"
    t.string "publication_date"
    t.string "url"
    t.string "doi"
    t.string "submitter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books_colleges", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "book_id", null: false
  end

  create_table "colleges", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colleges_other_publications", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "other_publication_id", null: false
  end

  create_table "other_publications", force: :cascade do |t|
    t.string "author_first_name"
    t.string "author_last_name"
    t.string "college_ids"
    t.string "uc_department"
    t.string "work_title"
    t.string "other_title"
    t.string "volume"
    t.string "issue"
    t.string "page_numbers"
    t.string "publisher"
    t.string "city"
    t.string "publication_date"
    t.string "url"
    t.string "doi"
    t.string "submitter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submitters", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "college"
    t.string "department"
    t.string "mailing_address"
    t.string "phone_number"
    t.string "email_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
