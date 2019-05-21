class CreateLancamentos < ActiveRecord::Migration
  def change
    create_table :lancamentos do |t|
      t.integer :processo
      t.date :data
      t.date :datadocumento
      t.string :observacao
      t.float :debito
      t.float :credito
      t.string :tipo
      t.integer :conta_id
      t.integer :fornecedor_id
      t.integer :item_de_despesa_id
      t.integer :item_de_receita_id
      t.integer :tipo_compra_id
      t.boolean :debito_cancelado
      t.float :retorno_debitocanc
      t.integer :num_notafiscal
      t.integer :empenho

      t.timestamps null: false
    end
  end
end
