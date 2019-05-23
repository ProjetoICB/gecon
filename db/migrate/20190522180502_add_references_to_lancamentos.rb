class AddReferencesToLancamentos < ActiveRecord::Migration
  def change
    add_column :lancamentos, :transferencia_id, :integer, index:true
  end

end
