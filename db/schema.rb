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

ActiveRecord::Schema[7.1].define(version: 2024_04_30_111519) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blockchain_payments", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "amount_cents"
    t.string "amount_currency"
    t.index ["user_id"], name: "index_blockchain_payments_on_user_id"
  end

  create_table "fee_configurations", force: :cascade do |t|
    t.string "uuid", null: false
    t.boolean "trades", default: true, null: false
    t.float "trades_percentage", default: 1.0
    t.boolean "payments", default: true, null: false
    t.float "payments_percentage", default: 1.0
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_fee_configurations_on_user_id"
  end

  create_table "fees", force: :cascade do |t|
    t.string "uuid", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.string "transactionable_type", null: false
    t.bigint "transactionable_id", null: false
    t.boolean "paid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transactionable_type", "transactionable_id"], name: "index_fees_on_transactionable"
  end

  create_table "fiat_payments", force: :cascade do |t|
    t.string "uuid", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "EUR", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_fiat_payments_on_user_id"
  end

  create_table "trades", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "original_amount_cents"
    t.string "original_amount_currency"
    t.float "final_amount_cents"
    t.string "final_amount_currency"
    t.index ["user_id"], name: "index_trades_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "uuid", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
