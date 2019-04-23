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

ActiveRecord::Schema.define(version: 2019_03_04_183940) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.string "street_address_1"
    t.string "street_address_2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "awards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "awardable_type"
    t.bigint "awardable_id"
    t.integer "starting_year"
    t.integer "ending_year"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "organization"
    t.index ["awardable_type", "awardable_id"], name: "index_awards_on_awardable_type_and_awardable_id"
  end

  create_table "colleges", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faculty", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "preferred_name"
    t.string "prefix"
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.string "suffix"
    t.string "email"
    t.string "wvu_username", limit: 30
    t.integer "role"
    t.integer "status"
    t.boolean "visible", default: false
    t.string "title"
    t.text "biography"
    t.text "research_interests"
    t.string "image"
    t.string "resume"
    t.bigint "college_id"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "teaching_interests"
    t.string "resume_year"
    t.index ["college_id"], name: "index_faculty_on_college_id"
    t.index ["department_id"], name: "index_faculty_on_department_id"
  end

  create_table "phones", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "phoneable_type"
    t.bigint "phoneable_id"
    t.string "number"
    t.integer "number_types"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phoneable_type", "phoneable_id"], name: "index_phones_on_phoneable_type_and_phoneable_id"
  end

  create_table "publications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "publishable_type"
    t.bigint "publishable_id"
    t.text "description"
    t.string "status"
    t.string "publisher"
    t.string "pagenum"
    t.integer "issue"
    t.integer "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.text "title"
    t.integer "starting_year"
    t.integer "ending_year"
    t.text "author"
    t.index ["publishable_type", "publishable_id"], name: "index_publications_on_publishable_type_and_publishable_id"
  end

  create_table "search_terms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "term"
    t.integer "term_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "preferred_name"
    t.string "prefix"
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.string "suffix"
    t.string "email"
    t.string "wvu_username", limit: 30
    t.integer "role"
    t.integer "status"
    t.boolean "visible", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "websites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "webable_type"
    t.bigint "webable_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["webable_type", "webable_id"], name: "index_websites_on_webable_type_and_webable_id"
  end

end
