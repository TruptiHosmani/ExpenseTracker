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

ActiveRecord::Schema.define(:version => 20120310210141) do

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.integer  "no_of_employees"
    t.float    "budget"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.date     "dob"
    t.integer  "department_id"
    t.integer  "job_title_id"
    t.integer  "manager_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "employees", ["department_id"], :name => "index_employees_on_department_id"
  add_index "employees", ["email"], :name => "index_employees_on_email", :unique => true
  add_index "employees", ["job_title_id"], :name => "index_employees_on_job_title_id"
  add_index "employees", ["manager_id"], :name => "index_employees_on_manager_id"
  add_index "employees", ["reset_password_token"], :name => "index_employees_on_reset_password_token", :unique => true

  create_table "expense_states", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "expense_types", :force => true do |t|
    t.string   "name"
    t.float    "max_expensable"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "expenses", :force => true do |t|
    t.date     "date"
    t.string   "description"
    t.float    "amount"
    t.integer  "employee_id"
    t.integer  "expense_type_id"
    t.integer  "payment_mode_id"
    t.integer  "vendor_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "expense_state_id"
    t.string   "receipt_file_name"
    t.string   "receipt_content_type"
    t.integer  "receipt_file_size"
    t.datetime "receipt_updated_at"
  end

  add_index "expenses", ["employee_id"], :name => "index_expenses_on_employee_id"
  add_index "expenses", ["expense_type_id"], :name => "index_expenses_on_expense_type_id"
  add_index "expenses", ["payment_mode_id"], :name => "index_expenses_on_payment_mode_id"
  add_index "expenses", ["vendor_id"], :name => "index_expenses_on_vendor_id"

  create_table "job_titles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payment_modes", :force => true do |t|
    t.string   "name"
    t.float    "max_allowed"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
