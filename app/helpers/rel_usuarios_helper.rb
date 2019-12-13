module RelUsuariosHelper

  def calculaSaldo(credito, debito)
    if debito.nil?
      debito = 0
    end
    saldo = credito - debito
    if saldo < -0.0001 and saldo > -0.99999
      saldo = 0
    end
    return saldo
  end

end
