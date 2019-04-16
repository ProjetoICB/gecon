class CreateItensDeReceita < ActiveRecord::Migration
  def change
    create_table :itens_de_receita do |t|
      t.string :nomeGecon
      t.string :nome
      t.string :coddigitado

      t.timestamps null: false
    end
  end
end
