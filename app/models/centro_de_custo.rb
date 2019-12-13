class CentroDeCusto < ActiveRecord::Base
  validates_presence_of :nome

  has_many :contas







































=begin

  def saldo(fim=nil)
    value = 0
    if fim.blank?
      fim = Date.today
    end

    self.contas.select{|conta| value += conta.saldo_em(fim) }
    return value
  end


=end

end
