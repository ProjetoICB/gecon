class AddAtivoToFontesDeRecurso < ActiveRecord::Migration
  def change
    add_column :fontes_de_recurso, :ativo, :boolean, default: true
  end
end
