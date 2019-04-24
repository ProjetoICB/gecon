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

ActiveRecord::Schema.define(version: 20190423193046) do

  create_table "centros_de_custo", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.boolean  "ativo"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "departamentos", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.string   "sigla",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "departamentos_usuarios", force: :cascade do |t|
    t.integer "departamento_id", limit: 4
    t.integer "usuario_id",      limit: 4
  end

  create_table "fontes_de_recurso", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "fornecedores", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "grupos", force: :cascade do |t|
    t.string   "nome",        limit: 255
    t.integer  "coddigitado", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "itens_de_despesa", force: :cascade do |t|
    t.string   "nomeGecon",  limit: 255
    t.string   "nome",       limit: 255
    t.string   "codigitado", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "itens_de_receita", force: :cascade do |t|
    t.string   "nomeGecon",   limit: 255
    t.string   "nome",        limit: 255
    t.string   "coddigitado", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "logs", force: :cascade do |t|
    t.string   "acao",       limit: 255
    t.string   "ip",         limit: 255
    t.integer  "usuario_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "logs", ["usuario_id"], name: "index_logs_on_usuario_id", using: :btree

  create_table "tipos_de_compra", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tipos_de_conta", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.integer  "grupo_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "nome",                limit: 255
    t.string   "email",               limit: 255
    t.string   "password_digest",     limit: 255
    t.string   "tipo",                limit: 255
    t.boolean  "ativo"
    t.string   "telefone",            limit: 255
    t.integer  "departamento",        limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "auth_token",          limit: 255
    t.string   "senha_reset_token",   limit: 255
    t.datetime "senha_reset_sent_at"
  end

  add_foreign_key "logs", "usuarios"
end
