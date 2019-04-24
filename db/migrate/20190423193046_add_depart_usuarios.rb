class AddDepartUsuarios < ActiveRecord::Migration
  def self.up
    create_table :departamentos_usuarios do |t|
      t.references :departamento, :usuario
    end
  end

  def self.down
    drop_table :departamentos_usuarios
  end
end
