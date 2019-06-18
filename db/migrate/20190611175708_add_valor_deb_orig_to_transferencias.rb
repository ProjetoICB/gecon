class AddValorDebOrigToTransferencias < ActiveRecord::Migration
  def change
    add_column :transferencias, :valor_deb_orig, :float
  end
end
