class RenameTableTiposDeConta < ActiveRecord::Migration
  def change
    rename_table :tipos_de_conta, :tipo_de_contas
  end
end
