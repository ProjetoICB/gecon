class AddAtivoToItensDeDespesa < ActiveRecord::Migration
  def change
    add_column :itens_de_despesa, :ativo, :boolean, default: true
  end
end
