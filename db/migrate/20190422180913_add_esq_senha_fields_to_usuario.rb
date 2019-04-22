class AddEsqSenhaFieldsToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :auth_token, :string
    add_column :usuarios, :senha_reset_token, :string
    add_column :usuarios, :senha_reset_sent_at, :datetime
  end
end

