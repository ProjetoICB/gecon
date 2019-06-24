class Lancamento < ActiveRecord::Base

  belongs_to :conta
  belongs_to :fornecedor
  belongs_to :item_de_despesa
  belongs_to :item_de_receita
  belongs_to :tipo_de_compra
  belongs_to :transferencia

  validates_presence_of :data
  validates_presence_of :datadocumento
  validates_presence_of :conta_id


end
