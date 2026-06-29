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

ActiveRecord::Schema[8.1].define(version: 2026_06_29_120002) do
  create_table "creators", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_creators_on_email", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "creator_id", null: false
    t.string "currency", default: "USD", null: false
    t.text "description"
    t.string "name", null: false
    t.integer "price_cents", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_products_on_creator_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "amount_cents", null: false
    t.string "buyer_email", null: false
    t.datetime "created_at", null: false
    t.integer "creator_id", null: false
    t.string "currency", default: "USD", null: false
    t.integer "product_id", null: false
    t.datetime "refunded_at"
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_sales_on_created_at"
    t.index ["creator_id"], name: "index_sales_on_creator_id"
    t.index ["product_id"], name: "index_sales_on_product_id"
  end

  add_foreign_key "products", "creators"
  add_foreign_key "sales", "creators"
  add_foreign_key "sales", "products"
end
