class AddTransfMultiplaIdToLancamentos < ActiveRecord::Migration
  def change
    add_column :lancamentos, :transf_multipla_id, :integer
  end
end
