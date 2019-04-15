class CreateTiposDeConta < ActiveRecord::Migration
  def change
    create_table :tipos_de_conta do |t|
      t.string :nome
      t.integer :grupo_id

      t.timestamps null: false
    end
  end
end
