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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141116115408) do

  create_table "agencies", force: true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.integer  "endpoint"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_available_forms", force: true do |t|
    t.string   "nombre"
    t.string   "tipo"
    t.boolean  "requerido"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "tipo"
    t.string   "marca"
    t.integer  "modelo"
    t.string   "linea"
    t.integer  "capacidad"
    t.string   "cc"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cantidad"
  end

  create_table "reserves", force: true do |t|
    t.integer  "agency_id"
    t.string   "productos"
    t.decimal  "monto",        precision: 5, scale: 2, default: 0.0
    t.date     "fecha_inicio"
    t.date     "fecha_fin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "nombre"
    t.string   "dpi"
    t.string   "telefono"
    t.string   "no_tarjeta"
  end

  add_index "reserves", ["agency_id"], name: "index_reserves_on_agency_id"

end
