class AddTransfMultiplaIdToTransferencias < ActiveRecord::Migration
  def change
    add_column :transferencias, :transf_multipla_id, :integer
  end
end
