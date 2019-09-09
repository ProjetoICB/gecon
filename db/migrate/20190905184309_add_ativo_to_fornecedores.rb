class AddAtivoToFornecedores < ActiveRecord::Migration
  def change
    add_column :fornecedores, :ativo, :boolean, default: true
  end
end
