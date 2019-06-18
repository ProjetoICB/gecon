class AddPorcentagemToTransferencias < ActiveRecord::Migration
  def change
    add_column :transferencias, :porcentagem, :integer
    add_column :transferencias, :transf_multipla, :boolean, default: false
  end
end
