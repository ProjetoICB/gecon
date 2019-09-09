class AddAtivoToDepartamentos < ActiveRecord::Migration
  def change
    add_column :departamentos, :ativo, :boolean, default: true
  end
end
