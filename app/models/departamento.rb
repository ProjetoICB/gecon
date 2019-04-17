class Departamento < ActiveRecord::Base
  validates_presence_of :nome
=begin
  has_many :departamentos_gerentes, dependent: :destroy
  has_many :usuarios, through: :departamentos_gerentes
=end

  has_many :usuarios

end
