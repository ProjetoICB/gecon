class CreateTransferencias < ActiveRecord::Migration
  def change
    create_table :transferencias do |t|
      t.date :data
      t.date :datadocumento
      t.integer :debito_id
      t.integer :credito_id
      t.float :valor
      t.text :observacao
      t.integer :fornecedor_id
      t.integer :num_notafiscal
      t.integer :empenho

      t.timestamps null: false
    end
  end
end
