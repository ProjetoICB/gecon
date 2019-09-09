class AddAtivoToTiposDeConta < ActiveRecord::Migration
  def change
    add_column :tipo_de_contas, :ativo, :boolean, default: true
  end
end
