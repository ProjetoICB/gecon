class Lancamento < ActiveRecord::Base

  belongs_to :conta
  belongs_to :fornecedor
  belongs_to :item_de_despesa
  belongs_to :item_de_receita
  belongs_to :tipo_de_compra

  validates_presence_of :processo
  validates_presence_of :data
  validates_presence_of :datadocumento
  validates_presence_of :conta_id
  validates_presence_of :fornecedor_id
  validates_presence_of :tipo_de_compra_id
  validates_presence_of :num_notafiscal
  validates_presence_of :empenho
  validates_numericality_of :num_notafiscal


end
