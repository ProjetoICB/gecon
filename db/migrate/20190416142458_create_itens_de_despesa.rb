class CreateItensDeDespesa < ActiveRecord::Migration
  def change
    create_table :itens_de_despesa do |t|
      t.string :nomeGecon
      t.string :nome
      t.string :codigitado

      t.timestamps null: false
    end
  end
end
