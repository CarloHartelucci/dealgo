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

ActiveRecord::Schema.define(:version => 20120808133647) do

  create_table "credit_card_types", :force => true do |t|
    t.string   "card_type"
    t.string   "card_description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "deal_thresholds", :force => true do |t|
    t.integer  "quantity"
    t.decimal  "price"
    t.integer  "deal_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "deal_thresholds", ["deal_id"], :name => "index_deal_thresholds_on_deal_id"

  create_table "deals", :force => true do |t|
    t.datetime "dealstart"
    t.datetime "dealend"
    t.integer  "maxquantity"
    t.string   "name"
    t.integer  "merchant_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
  end

  add_index "deals", ["merchant_id"], :name => "index_deals_on_merchant_id"

  create_table "merchants", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "twitter"
    t.string   "facebook"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payment_infos", :force => true do |t|
    t.string   "card_number"
    t.integer  "expiration_month"
    t.integer  "expiration_year"
    t.string   "card_type"
    t.integer  "purchaser_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "payment_infos", ["purchaser_id"], :name => "index_payment_infos_on_purchaser_id"

  create_table "purchasers", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "purchases", :force => true do |t|
    t.integer  "quantity"
    t.datetime "purchased_at"
    t.integer  "deal_id"
    t.integer  "purchaser_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "purchases", ["deal_id"], :name => "index_purchases_on_deal_id"
  add_index "purchases", ["purchaser_id"], :name => "index_purchases_on_purchaser_id"

end
