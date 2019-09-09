class AddAtivoToGrupos < ActiveRecord::Migration
  def change
    add_column :grupos, :ativo, :boolean, default: true
  end
end
