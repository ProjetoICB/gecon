class Mensagem < ApplicationMailer

  def senha_reset(usuario)
    @usuario = usuario
    mail({
             to: @usuario.email,
             subject: "Alteração de senha",
             date: Time.now
         })
  end
end
