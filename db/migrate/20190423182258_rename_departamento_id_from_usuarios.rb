class RenameDepartamentoIdFromUsuarios < ActiveRecord::Migration
  def change
    rename_column :usuarios, :departamento_id, :departamento
  end
end
