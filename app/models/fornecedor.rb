class Fornecedor < ActiveRecord::Base

  has_many :lancamentos

  validates_presence_of :nome
end
