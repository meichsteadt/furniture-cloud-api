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

ActiveRecord::Schema.define(version: 20190715222558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ahoy_events", force: :cascade do |t|
    t.integer  "visit_id"
    t.integer  "user_id"
    t.string   "name"
    t.jsonb    "properties"
    t.datetime "time"
    t.integer  "product_id"
    t.integer  "store_id"
    t.index "properties jsonb_path_ops", name: "index_ahoy_events_on_properties_jsonb_path_ops", using: :gin
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time", using: :btree
    t.index ["user_id"], name: "index_ahoy_events_on_user_id", using: :btree
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id", using: :btree
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string   "visit_token"
    t.string   "visitor_token"
    t.integer  "user_id"
    t.string   "ip"
    t.text     "user_agent"
    t.text     "referrer"
    t.string   "referring_domain"
    t.text     "landing_page"
    t.string   "browser"
    t.string   "os"
    t.string   "device_type"
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.string   "app_version"
    t.string   "os_version"
    t.string   "platform"
    t.datetime "started_at"
    t.integer  "store_id"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id", using: :btree
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true, using: :btree
  end

  create_table "brands", force: :cascade do |t|
    t.string   "logo"
    t.string   "name"
    t.string   "brand_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "image"
    t.integer  "parent_category_id"
    t.boolean  "has_sets",           default: false
  end

  create_table "categories_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_categories_products_on_category_id", using: :btree
    t.index ["product_id"], name: "index_categories_products_on_product_id", using: :btree
  end

  create_table "categories_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_categories_users_on_category_id", using: :btree
    t.index ["user_id"], name: "index_categories_users_on_user_id", using: :btree
  end

  create_table "color_palletes", force: :cascade do |t|
    t.string   "primary_color"
    t.string   "secondary_color"
    t.string   "highlight_color"
    t.string   "lowlight_color"
    t.string   "accent_color"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_customers_on_store_id", using: :btree
  end

  create_table "deliveries", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_deliveries_on_store_id", using: :btree
  end

  create_table "financings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "logo"
    t.boolean  "credit_needed"
    t.string   "length"
    t.boolean  "bank_account"
    t.string   "url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id"], name: "index_financings_on_user_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "url"
    t.integer  "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_images_on_store_id", using: :btree
  end

  create_table "info_requests", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "product_id"
    t.integer  "customer_id"
    t.string   "name"
    t.string   "email"
    t.string   "note"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["product_id"], name: "index_info_requests_on_product_id", using: :btree
    t.index ["store_id"], name: "index_info_requests_on_store_id", using: :btree
  end

  create_table "init_models", force: :cascade do |t|
    t.string   "init_modelable_type"
    t.integer  "init_modelable_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["init_modelable_type", "init_modelable_id"], name: "index_init_models_on_init_modelable_type_and_init_modelable_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.text     "benefits"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials_mattresses", force: :cascade do |t|
    t.integer "mattress_id"
    t.integer "material_id"
    t.index ["material_id"], name: "index_materials_mattresses_on_material_id", using: :btree
    t.index ["mattress_id"], name: "index_materials_mattresses_on_mattress_id", using: :btree
  end

  create_table "mattresses", force: :cascade do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.string   "comfort"
    t.string   "image"
    t.text     "description"
    t.integer  "warranty"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["brand_id"], name: "index_mattresses_on_brand_id", using: :btree
  end

  create_table "mattresses_users", force: :cascade do |t|
    t.integer "mattress_id"
    t.integer "user_id"
    t.index ["mattress_id"], name: "index_mattresses_users_on_mattress_id", using: :btree
    t.index ["user_id"], name: "index_mattresses_users_on_user_id", using: :btree
  end

  create_table "nav_tops", force: :cascade do |t|
    t.string   "copy"
    t.integer  "user_id"
    t.string   "color"
    t.string   "link"
    t.string   "shape"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parent_categories", force: :cascade do |t|
    t.string  "name"
    t.string  "image"
    t.integer "user_id"
    t.index ["user_id"], name: "index_parent_categories_on_user_id", using: :btree
  end

  create_table "prices", force: :cascade do |t|
    t.integer "product_item_id"
    t.integer "user_id"
    t.decimal "price"
    t.index ["product_item_id"], name: "index_prices_on_product_item_id", using: :btree
    t.index ["user_id"], name: "index_prices_on_user_id", using: :btree
  end

  create_table "product_items", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "name"
    t.string   "dimensions"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_items_on_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.text     "description"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "thumbnail"
    t.string   "set_name"
    t.string   "images",      default: [],              array: true
    t.string   "set_desc"
    t.index ["brand_id"], name: "index_products_on_brand_id", using: :btree
  end

  create_table "products_promotions", force: :cascade do |t|
    t.integer "product_id"
    t.integer "promotion_id"
    t.index ["product_id"], name: "index_products_promotions_on_product_id", using: :btree
    t.index ["promotion_id"], name: "index_products_promotions_on_promotion_id", using: :btree
  end

  create_table "products_set_types", force: :cascade do |t|
    t.integer "product_id"
    t.integer "set_type_id"
  end

  create_table "products_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.index ["product_id"], name: "index_products_users_on_product_id", using: :btree
    t.index ["user_id"], name: "index_products_users_on_user_id", using: :btree
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.decimal  "discount",   default: "0.9"
    t.integer  "user_id"
  end

  create_table "related_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "related_product_id"
    t.index ["product_id"], name: "index_related_products_on_product_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "name"
    t.text     "review"
    t.float    "stars"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_reviews_on_store_id", using: :btree
  end

  create_table "set_prices", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_set_prices_on_product_id", using: :btree
    t.index ["user_id"], name: "index_set_prices_on_user_id", using: :btree
  end

  create_table "set_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sizes", force: :cascade do |t|
    t.integer  "mattress_id"
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.decimal  "mat_only"
    t.index ["mattress_id"], name: "index_sizes_on_mattress_id", using: :btree
    t.index ["user_id"], name: "index_sizes_on_user_id", using: :btree
  end

  create_table "stores", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "google_maps"
    t.string   "yelp"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "google_reviews_id"
    t.string   "twitter"
    t.string   "yellow_pages"
    t.boolean  "show_prices",       default: true
    t.boolean  "promotions",        default: true
    t.string   "name"
    t.string   "logo"
    t.string   "url"
    t.string   "favicon"
    t.string   "key"
    t.string   "password_digest"
    t.integer  "color_pallete_id",  default: 1
    t.string   "email"
  end

  create_table "user_keys", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "password_digest"
    t.string   "key"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_user_keys_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "google_analytics"
    t.float    "markup_default"
  end

  add_foreign_key "categories_users", "categories"
  add_foreign_key "categories_users", "users"
  add_foreign_key "deliveries", "stores"
  add_foreign_key "financings", "users"
  add_foreign_key "images", "stores"
  add_foreign_key "materials_mattresses", "materials"
  add_foreign_key "materials_mattresses", "mattresses"
  add_foreign_key "mattresses", "brands"
  add_foreign_key "reviews", "stores"
  add_foreign_key "set_prices", "products"
  add_foreign_key "set_prices", "users"
  add_foreign_key "sizes", "mattresses"
  add_foreign_key "user_keys", "users"
end
