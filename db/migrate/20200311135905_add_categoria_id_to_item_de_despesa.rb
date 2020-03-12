class AddCategoriaIdToItemDeDespesa < ActiveRecord::Migration
  def change
    add_column :itens_de_despesa, :categoria_id, :integer
  end
end
