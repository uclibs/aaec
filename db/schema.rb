# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_09_20_023655) do

  create_table "artworks", force: :cascade do |t|
    t.string "author_first_name"
    t.string "author_last_name"
    t.string "college_ids"
    t.string "other_college"
    t.string "uc_department"
    t.string "work_title"
    t.string "other_title"
    t.string "location"
    t.string "date"
    t.string "submitter_id"
  end

  create_table "artworks_colleges", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "artwork_id", null: false
  end

  create_table "book_chapters", force: :cascade do |t|
    t.string "author_first_name"
    t.string "author_last_name"
    t.string "college_ids"
    t.string "other_college"
    t.string "uc_department"
    t.string "work_title"
    t.string "other_title"
    t.string "publisher"
    t.string "city"
    t.string "publication_date"
    t.string "url"
    t.string "doi"
    t.string "submitter_id"
    t.string "page_numbers"
  end

  create_table "book_chapters_colleges", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "book_chapter_id", null: false
  end

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
    t.string "other_college"
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

  create_table "colleges_digital_projects", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "digital_project_id", null: false
  end

  create_table "colleges_editings", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "editing_id", null: false
  end

  create_table "colleges_films", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "film_id", null: false
  end

  create_table "colleges_journal_articles", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "journal_article_id", null: false
  end

  create_table "colleges_musical_scores", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "musical_score_id", null: false
  end

  create_table "colleges_other_publications", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "other_publication_id", null: false
  end

  create_table "colleges_photographies", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "photography_id", null: false
  end

  create_table "colleges_physical_media", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "physical_medium_id", null: false
  end

  create_table "colleges_plays", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "play_id", null: false
  end

  create_table "colleges_public_performances", id: false, force: :cascade do |t|
    t.integer "college_id", null: false
    t.integer "public_performance_id", null: false
  end

  create_table "digital_projects", force: :cascade do |t|
    t.string "author_first_name"
    t.string "author_last_name"
    t.string "college_ids"
    t.string "other_college"
    t.string "uc_department"
    t.string "work_title"
    t.string "other_title"
    t.string "name_of_site"
    t.string "name_of_affiliated_organization"
    t.string "publication_date"
    t.string "version"
    t.string "url"
    t.string "doi"
    t.string "submitter_id"
  end

  create_table "editings", force: :cascade do |t|
    t.string "author_first_name"
    t.string "author_last_name"
    t.string "college_ids"
    t.string "other_college"
    t.string "uc_department"
    t.string "work_title"
    t.string "other_title"
    t.string "volume"
    t.string "issue"
    t.string "publisher"
    t.string "city"
    t.string "publication_date"
    t.string "url"
    t.string "doi"
    t.string "submitter_id"
  end

  create_table "films", force: :cascade do |t|
    t.string "author_first_name"
    t.string "author_last_name"
    t.string "college_ids"
    t.string "other_college"
    t.string "uc_department"
    t.string "work_title"
    t.string "other_title"
    t.string "producer"
    t.string "director"
    t.string "release_year"
    t.string "submitter_id"
  end

  create_table "journal_articles", force: :cascade do |t|
    t.string "author_first_name"
    t.string "author_last_name"
    t.string "college_ids"
    t.string "other_college"
    t.string "uc_department"
    t.string "work_title"
    t.string "other_title"
    t.string "volume"
    t.string "issue"
    t.string "page_numbers"
    t.string "publication_date"
    t.string "url"
    t.string "doi"
    t.string "submitter_id"
  end

  create_table "musical_scores", force: :cascade do |t|
    t.string "author_first_name"
    t.string "author_last_name"
    t.string "college_ids"
    t.string "other_college"
    t.string "uc_department"
    t.string "work_title"
    t.string "other_title"
    t.string "publisher"
    t.string "city"
    t.string "publication_date"
    t.string "url"
    t.string "doi"
    t.string "submitter_id"
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
    t.string "other_college"
  end

  create_table "photographies", force: :cascade do |t|
    t.string "author_first_name"
    t.string "author_last_name"
    t.string "college_ids"
    t.string "other_college"
    t.string "uc_department"
    t.string "work_title"
    t.string "other_title"
    t.string "publisher"
    t.string "city"
    t.string "publication_date"
    t.string "url"
    t.string "doi"
    t.string "submitter_id"
  end

  create_table "physical_media", force: :cascade do |t|
    t.string "author_first_name"
    t.string "author_last_name"
    t.string "college_ids"
    t.string "other_college"
    t.string "uc_department"
    t.string "work_title"
    t.string "other_title"
    t.string "publisher"
    t.string "city"
    t.string "publication_date"
    t.string "url"
    t.string "doi"
    t.string "submitter_id"
  end

  create_table "plays", force: :cascade do |t|
    t.string "author_first_name"
    t.string "author_last_name"
    t.string "college_ids"
    t.string "other_college"
    t.string "uc_department"
    t.string "work_title"
    t.string "other_title"
    t.string "publisher"
    t.string "city"
    t.string "publication_date"
    t.string "url"
    t.string "doi"
    t.string "submitter_id"
  end

  create_table "public_performances", force: :cascade do |t|
    t.string "author_first_name"
    t.string "author_last_name"
    t.string "college_ids"
    t.string "other_college"
    t.string "uc_department"
    t.string "work_title"
    t.string "other_title"
    t.string "location"
    t.string "time"
    t.string "date"
    t.string "submitter_id"
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
