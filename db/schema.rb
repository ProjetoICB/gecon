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

ActiveRecord::Schema.define(version: 20190719192730) do

  create_table "centros_de_custo", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.boolean  "ativo"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "contas", force: :cascade do |t|
    t.string   "numero",              limit: 255
    t.string   "nome",                limit: 255
    t.text     "observacao",          limit: 65535
    t.boolean  "ativo"
    t.integer  "tipo_de_conta_id",    limit: 4,     null: false
    t.integer  "usuario_id",          limit: 4,     null: false
    t.integer  "centro_de_custo_id",  limit: 4,     null: false
    t.integer  "fonte_de_recurso_id", limit: 4,     null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "contas", ["centro_de_custo_id"], name: "index_contas_on_centro_de_custo_id", using: :btree
  add_index "contas", ["fonte_de_recurso_id"], name: "index_contas_on_fonte_de_recurso_id", using: :btree
  add_index "contas", ["tipo_de_conta_id"], name: "index_contas_on_tipo_de_conta_id", using: :btree
  add_index "contas", ["usuario_id"], name: "index_contas_on_usuario_id", using: :btree

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

  create_table "lancamentos", force: :cascade do |t|
    t.integer  "processo",           limit: 4
    t.date     "data"
    t.date     "datadocumento"
    t.string   "observacao",         limit: 255
    t.float    "debito",             limit: 24
    t.float    "credito",            limit: 24
    t.string   "tipo",               limit: 255
    t.integer  "conta_id",           limit: 4
    t.integer  "fornecedor_id",      limit: 4
    t.integer  "item_de_despesa_id", limit: 4
    t.integer  "item_de_receita_id", limit: 4
    t.integer  "tipo_de_compra_id",  limit: 4
    t.boolean  "debito_cancelado"
    t.float    "retorno_debitocanc", limit: 24
    t.integer  "num_notafiscal",     limit: 4
    t.integer  "empenho",            limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "transferencia_id",   limit: 4
    t.integer  "transf_multipla_id", limit: 4
  end

  create_table "logs", force: :cascade do |t|
    t.string   "acao",       limit: 255
    t.string   "ip",         limit: 255
    t.integer  "usuario_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "logs", ["usuario_id"], name: "index_logs_on_usuario_id", using: :btree

  create_table "tipo_de_contas", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.integer  "grupo_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tipos_de_compra", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "transferencias", force: :cascade do |t|
    t.date     "data"
    t.date     "datadocumento"
    t.integer  "debito_id",          limit: 4
    t.integer  "credito_id",         limit: 4
    t.float    "valor",              limit: 24
    t.text     "observacao",         limit: 65535
    t.integer  "fornecedor_id",      limit: 4
    t.integer  "num_notafiscal",     limit: 4
    t.integer  "empenho",            limit: 4
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "porcentagem",        limit: 4
    t.boolean  "transf_multipla",                  default: false
    t.float    "valor_deb_orig",     limit: 24
    t.integer  "transf_multipla_id", limit: 4
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "nome",                limit: 255
    t.string   "email",               limit: 255
    t.string   "password_digest",     limit: 255
    t.string   "tipo",                limit: 255
    t.boolean  "ativo"
    t.string   "telefone",            limit: 255
    t.integer  "departamento_id",     limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "auth_token",          limit: 255
    t.string   "senha_reset_token",   limit: 255
    t.datetime "senha_reset_sent_at"
  end

  add_foreign_key "logs", "usuarios"
end
