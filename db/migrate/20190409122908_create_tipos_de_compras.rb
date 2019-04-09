class CreateTiposDeCompras < ActiveRecord::Migration
  def change
    create_table :tipos_de_compras do |t|
      t.string :nome

      t.timestamps null: false
    end
  end
end
