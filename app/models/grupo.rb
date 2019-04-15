class Grupo < ActiveRecord::Base

  has_many :tipo_de_contas

  validates_presence_of :nome

end
