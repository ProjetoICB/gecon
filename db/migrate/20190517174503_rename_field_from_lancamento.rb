class RenameFieldFromLancamento < ActiveRecord::Migration
  def change
    rename_column :lancamentos, :tipo_compra_id, :tipo_de_compra_id
  end
end
