class ItemDeDespesa < ActiveRecord::Base

  has_many :lancamentos
  belongs_to :categoria

  validates_presence_of :nome
end
