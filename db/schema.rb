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

ActiveRecord::Schema.define(:version => 20121023022004) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "fulfillments", :force => true do |t|
    t.integer  "order_id",                                          :null => false
    t.integer  "fulfillment_id"
    t.string   "tracking_company", :limit => 64
    t.string   "tracking_number",  :limit => 64
    t.boolean  "received",                       :default => false
    t.string   "receiver",         :limit => 32
    t.datetime "received_at"
    t.datetime "created_at",                                        :null => false
  end

  add_index "fulfillments", ["order_id"], :name => "index_fulfillments_on_order_id"

  create_table "orders", :force => true do |t|
    t.integer "shop_id",                     :null => false
    t.integer "order_id",                    :null => false
    t.string  "name",          :limit => 16, :null => false
    t.string  "customer_name", :limit => 32, :null => false
    t.float   "total_price",                 :null => false
  end

  add_index "orders", ["order_id"], :name => "index_orders_on_order_id", :unique => true

  create_table "shops", :force => true do |t|
    t.integer "shop_id",                     :null => false
    t.string  "name",          :limit => 32, :null => false
    t.string  "shopqi_domain", :limit => 64, :null => false
    t.string  "email",         :limit => 32, :null => false
    t.string  "access_token",  :limit => 64
  end

  add_index "shops", ["shop_id"], :name => "index_shops_on_shop_id", :unique => true

  create_table "trackings", :force => true do |t|
    t.integer  "fulfillment_id"
    t.datetime "time",           :null => false
    t.string   "context",        :null => false
  end

  add_index "trackings", ["fulfillment_id"], :name => "index_trackings_on_fulfillment_id"

end
