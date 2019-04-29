class CentroDeCusto < ActiveRecord::Base
  validates_presence_of :nome

  has_many :contas
end
