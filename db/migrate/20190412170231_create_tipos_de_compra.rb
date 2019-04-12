class CreateTiposDeCompra < ActiveRecord::Migration
  def change
    create_table :tipos_de_compra do |t|
      t.string :nome

      t.timestamps null: false
    end
  end
end
