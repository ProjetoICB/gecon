class Conta < ActiveRecord::Base
  belongs_to :tipo_de_conta
  belongs_to :usuario
  belongs_to :centro_de_custo
  belongs_to :fonte_de_recurso
end
