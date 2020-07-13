class Categoria < ActiveRecord::Base

  has_many :item_de_despesas

  validates_presence_of :nome

end
