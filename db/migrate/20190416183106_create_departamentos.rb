class CreateDepartamentos < ActiveRecord::Migration
  def change
    create_table :departamentos do |t|
      t.string :nome
      t.string :sigla

      t.timestamps null: false
    end
  end
end
