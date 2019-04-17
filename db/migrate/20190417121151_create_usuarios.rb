class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nome
      t.string :email
      t.string :password_digest
      t.string :tipo
      t.boolean :ativo
      t.string :telefone
      t.references :departamento

      t.timestamps null: false


    end
  end
end
