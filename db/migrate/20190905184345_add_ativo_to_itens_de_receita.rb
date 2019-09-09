class AddAtivoToItensDeReceita < ActiveRecord::Migration
  def change
    add_column :itens_de_receita, :ativo, :boolean, default: true
  end
end
