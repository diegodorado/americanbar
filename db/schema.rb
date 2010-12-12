# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100901061438) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "nombre_fantasia"
    t.string   "cuit"
    t.string   "direccion"
    t.string   "localidad"
    t.string   "provincia"
    t.string   "cp"
    t.string   "condicion_venta"
    t.boolean  "descuento10"
    t.boolean  "descuento20"
    t.string   "remito_direccion"
    t.string   "remito_localidad"
    t.string   "remito_provincia"
    t.string   "remito_cp"
    t.string   "email"
    t.string   "tel_fax"
    t.text     "observaciones"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ri"
  end

  create_table "invoice_products", :force => true do |t|
    t.integer  "quantity"
    t.float    "price"
    t.integer  "invoice_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.float    "total"
  end

  create_table "invoices", :force => true do |t|
    t.date     "date"
    t.string   "nro"
    t.string   "remito_nro"
    t.text     "details"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_descuento_10"
    t.boolean  "has_descuento_20"
    t.float    "iva_percent"
    t.string   "condicion_venta"
    t.float    "subtotal"
  end

  add_index "invoices", ["iva_percent"], :name => "index_invoices_on_iva_percent"

  create_table "netzke_field_lists", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.string   "model_name"
    t.integer  "user_id"
    t.integer  "role_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "netzke_preferences", :force => true do |t|
    t.string   "name"
    t.string   "pref_type"
    t.text     "value"
    t.integer  "user_id"
    t.integer  "role_id"
    t.string   "widget_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "login",                              :null => false
    t.integer  "role_id",                            :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
