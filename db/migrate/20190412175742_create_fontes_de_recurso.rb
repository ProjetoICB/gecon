class CreateFontesDeRecurso < ActiveRecord::Migration
  def change
    create_table :fontes_de_recurso do |t|
      t.string :nome

      t.timestamps null: false
    end
  end
end
