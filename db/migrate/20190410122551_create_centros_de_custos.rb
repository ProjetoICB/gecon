class CreateCentrosDeCustos < ActiveRecord::Migration
  def change
    create_table :centros_de_custos do |t|
      t.string :nome
      t.boolean :ativo

      t.timestamps null: false
    end
  end
end
