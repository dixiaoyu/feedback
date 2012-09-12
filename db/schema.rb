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

ActiveRecord::Schema.define(:version => 20120904075521) do

  create_table "branches", :force => true do |t|
    t.string   "coy"
    t.string   "branch_id"
    t.string   "branch_name"
    t.string   "company_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "no_of_year"
    t.integer  "qty_of_employee"
    t.string   "rcb_no"
    t.string   "ta_licence_no"
    t.string   "lata_no"
    t.string   "contact_person"
    t.string   "contact_no"
    t.string   "contact_email"
    t.string   "address"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "case_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "coy"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "cases", :force => true do |t|
    t.string   "coy"
    t.string   "case_id"
    t.datetime "incident_date"
    t.text     "content"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "category"
    t.string   "status"
    t.string   "title"
    t.string   "company_name"
    t.string   "company_id"
    t.string   "branch_name"
    t.string   "branch_id"
    t.string   "created_by"
    t.string   "updated_by"
    t.string   "poc"
  end

  create_table "companies", :force => true do |t|
    t.string   "coy"
    t.string   "company_id"
    t.string   "company_name"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "type_of_organization"
    t.string   "type_of_ownership"
    t.integer  "no_of_year"
    t.integer  "qty_of_employee"
    t.string   "rcb_no"
    t.string   "ta_licence_no"
    t.string   "lata_no"
    t.string   "contact_person"
    t.string   "contact_no"
    t.string   "contact_email"
    t.string   "address"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "group_cates", :force => true do |t|
    t.string   "coy"
    t.string   "group_id"
    t.string   "category_id"
    t.string   "view"
    t.string   "process"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "coy"
    t.string   "group_id"
    t.string   "group"
    t.string   "dept"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "branch"
  end

  create_table "processings", :force => true do |t|
    t.string   "coy"
    t.string   "case_id"
    t.text     "reply_content"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "created_by"
    t.string   "updated_by"
    t.string   "response_type"
    t.string   "response_to"
    t.string   "attachment"
  end

  create_table "users", :force => true do |t|
    t.string   "user_id"
    t.string   "pwd"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "coy"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "contact"
    t.string   "gender"
    t.string   "address"
    t.string   "user_group"
    t.string   "title"
    t.string   "level"
    t.datetime "last_login"
    t.datetime "pwd_changed"
    t.string   "poc"
    t.string   "company_name"
    t.string   "company_id"
    t.string   "branch_name"
    t.string   "branch_id"
    t.string   "created_by"
    t.string   "updated_by"
    t.string   "group_id"
  end

  add_index "users", ["user_id"], :name => "index_users_on_user_id", :unique => true

end
