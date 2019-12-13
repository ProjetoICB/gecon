class Conta < ActiveRecord::Base
  belongs_to :tipo_de_conta
  belongs_to :usuario
  belongs_to :centro_de_custo
  belongs_to :fonte_de_recurso
  has_many :lancamentos, dependent: :destroy


  def full_name
    "#{id} - #{nome}"
  end


=begin
  def saldo_em(data)
    value = 0
    self.lancamentos.select{|lanc| lanc.data <= data}.each{|lanc| value += lanc.credito.to_f - lanc.debito.to_f }
  end

=end

end