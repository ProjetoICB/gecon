class CreateGrupos < ActiveRecord::Migration
  def change
    create_table :grupos do |t|
      t.string :nome
      t.integer :coddigitado

      t.timestamps null: false
    end
  end
end
