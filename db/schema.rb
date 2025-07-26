# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_07_100026) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "balance_histories", force: :cascade do |t|
    t.decimal "amount", default: "0.0"
    t.integer "status", default: 0
    t.date "trans_date"
    t.text "description"
    t.bigint "balance_id"
    t.string "source_type"
    t.bigint "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["balance_id"], name: "index_balance_histories_on_balance_id"
    t.index ["source_type", "source_id"], name: "index_balance_histories_on_source"
  end

  create_table "balances", force: :cascade do |t|
    t.date "period"
    t.decimal "previous_mutation", default: "0.0"
    t.decimal "current_mutation", default: "0.0"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_balances_on_user_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "cart_id"
    t.bigint "event_id"
    t.bigint "ticket_stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["event_id"], name: "index_cart_items_on_event_id"
    t.index ["ticket_stock_id"], name: "index_cart_items_on_ticket_stock_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "cart_items_count", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "country_code"
    t.string "country_name"
    t.string "nationality_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_sessions", force: :cascade do |t|
    t.string "title"
    t.integer "status", default: 0
    t.boolean "is_current", default: false
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_sessions_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "speaker"
    t.datetime "published_date"
    t.string "platform_url"
    t.boolean "ticket_start_selling", default: true
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "images", force: :cascade do |t|
    t.text "image_data"
    t.string "uploadable_type"
    t.bigint "uploadable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uploadable_type", "uploadable_id"], name: "index_images_on_uploadable"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "trans_id"
    t.decimal "total"
    t.text "detail"
    t.text "remark"
    t.string "status"
    t.datetime "paydate"
    t.string "invoice_uid"
    t.bigint "user_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_invoices_on_order_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "price"
    t.string "product_name"
    t.text "product_details"
    t.bigint "order_id"
    t.bigint "order_temp_id"
    t.bigint "event_id"
    t.bigint "ticket_stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_order_items_on_event_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["order_temp_id"], name: "index_order_items_on_order_temp_id"
    t.index ["ticket_stock_id"], name: "index_order_items_on_ticket_stock_id"
  end

  create_table "order_temps", force: :cascade do |t|
    t.decimal "total"
    t.string "phone_number"
    t.string "recepient_name"
    t.string "payment_method"
    t.string "status"
    t.string "remark"
    t.boolean "use_balance", default: false
    t.decimal "use_balance_amount"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_order_temps_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "total"
    t.string "phone_number"
    t.string "recepient_name"
    t.string "payment_method"
    t.string "status"
    t.string "remark"
    t.boolean "use_balance", default: false
    t.decimal "use_balance_amount"
    t.string "order_uid"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "ticket_sessions", force: :cascade do |t|
    t.datetime "in_time"
    t.datetime "out_time"
    t.string "visitor_id_in"
    t.string "visitor_id_out"
    t.bigint "ticket_id"
    t.bigint "user_id"
    t.bigint "event_id"
    t.bigint "event_session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_ticket_sessions_on_event_id"
    t.index ["event_session_id"], name: "index_ticket_sessions_on_event_session_id"
    t.index ["ticket_id"], name: "index_ticket_sessions_on_ticket_id"
    t.index ["user_id"], name: "index_ticket_sessions_on_user_id"
  end

  create_table "ticket_stocks", force: :cascade do |t|
    t.string "name"
    t.string "sku"
    t.text "description"
    t.boolean "go_live", default: false
    t.string "slug"
    t.integer "quantity", default: 0
    t.decimal "price", default: "0.0"
    t.date "start_sale"
    t.date "end_sale"
    t.integer "sold_quantity", default: 0
    t.integer "total_stock", default: 0
    t.bigint "event_id"
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_ticket_stocks_on_admin_id"
    t.index ["event_id"], name: "index_ticket_stocks_on_event_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "attendee_name"
    t.string "remark"
    t.string "link_token"
    t.string "fake_email"
    t.string "code"
    t.string "visitor_id"
    t.text "api_response"
    t.bigint "last_ticket_session_id"
    t.bigint "event_id"
    t.bigint "order_item_id"
    t.bigint "ticket_stock_id"
    t.bigint "ownership_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
    t.index ["last_ticket_session_id"], name: "index_tickets_on_last_ticket_session_id"
    t.index ["order_item_id"], name: "index_tickets_on_order_item_id"
    t.index ["ownership_id"], name: "index_tickets_on_ownership_id"
    t.index ["ticket_stock_id"], name: "index_tickets_on_ticket_stock_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.string "user_uid"
    t.string "full_name"
    t.string "nric"
    t.date "dob"
    t.integer "gender"
    t.integer "marital_status"
    t.string "company"
    t.string "job"
    t.text "avatar_data"
    t.string "city"
    t.string "postcode"
    t.string "address"
    t.string "mobile_phone"
    t.string "home_number"
    t.string "facebook"
    t.string "instagram"
    t.string "linkedin"
    t.bigint "user_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_user_profiles_on_country_id"
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "default_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "state"
    t.string "postcode"
    t.string "contact"
    t.text "full_address"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_venues_on_country_id"
  end

  add_foreign_key "tickets", "ticket_sessions", column: "last_ticket_session_id"
end
