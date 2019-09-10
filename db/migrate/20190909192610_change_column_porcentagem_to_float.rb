class ChangeColumnPorcentagemToFloat < ActiveRecord::Migration
  def change
    change_column :transferencias, :porcentagem, :float, scale: 3
  end
end
