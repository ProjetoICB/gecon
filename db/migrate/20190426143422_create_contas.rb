class CreateContas < ActiveRecord::Migration
  def change
    create_table :contas do |t|
      t.string :numero
      t.string :nome
      t.text :observacao
      t.boolean :ativo
      t.references :tipo_de_conta, index: true, foreign_key: true, null: false
      t.references :usuario, index: true, foreign_key: true, null: false
      t.references :centro_de_custo, index: true, foreign_key: true, null: false
      t.references :fonte_de_recurso, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
