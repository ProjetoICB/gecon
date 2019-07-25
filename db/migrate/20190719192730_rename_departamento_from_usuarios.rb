class RenameDepartamentoFromUsuarios < ActiveRecord::Migration
  def change
    rename_column :usuarios, :departamento, :departamento_id
  end
end
