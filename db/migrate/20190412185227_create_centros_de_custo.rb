class CreateCentrosDeCusto < ActiveRecord::Migration
  def change
    create_table :centros_de_custo do |t|
      t.string :nome
      t.boolean :ativo

      t.timestamps null: false
    end
  end
end
