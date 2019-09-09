class AddAtivoToTiposDeCompra < ActiveRecord::Migration
  def change
    add_column :tipos_de_compra, :ativo, :boolean, default: true
  end
end
