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

ActiveRecord::Schema.define(:version => 3) do

  create_table "accounts", :force => true do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "crypted_password"
    t.string "role"
  end

  create_table "admin_configurations", :force => true do |t|
    t.string  "model_name"
    t.string  "fieldset"
    t.text    "contains"
    t.boolean "hide"
    t.string  "label"
    t.string  "validation"
  end

  create_table "musicians", :force => true do |t|
    t.string "title"
    t.string "profile_img"
  end

end
