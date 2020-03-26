module RelUsuariosHelper

  def calculaSaldo(credito, debito)
    if debito.nil?
      debito = 0
    end
    saldo = credito - debito
    if saldo < -0.0000000000000000000000001 and saldo > -0.99999999999999999999999999 and saldo > 0.0000000000000000000000001 and saldo < 0.9999999999999999999999999
      saldo = 0
    end
    return saldo
  end

end
