class SenhaResetsController < ApplicationController

  def create
    usuario = Usuario.find_by_email(params[:email])
    if usuario
      send_senha_reset(usuario)
      redirect_to root_url, notice: "Verifique seu e-mail"
    else
      redirect_to root_url, notice:  "Usuário não encontrado"

    end
  end


  def edit
    @usuario = Usuario.find_by_senha_reset_token!(params[:id])
    if @usuario.senha_reset_sent_at < 2.hours.ago
      redirect_to new_senha_reset_path, notice: "Tempo de alteração de senha expirado"
    end
  end

  def update
    @usuario = Usuario.find_by_senha_reset_token!(params[:id])
    if @usuario.senha_reset_sent_at < 2.hours.ago
      redirect_to new_senha_reset_path, notice: "Tempo de alteração de senha expirado"
    else
      if @usuario.update_attributes(usuario_params)
        redirect_to root_url, notice: "Senha foi alterada"
      else
        render :edit
      end
    end
  end


  private
  def usuario_params
    params.require(:usuario).permit(:nome, :email, :password, :password_confirmation, :tipo, :ativo, :telefone, :departamento_id)
  end


  def send_senha_reset(usuario)
    usuario.senha_reset_token = Digest::SHA2.hexdigest("abc123-321cba#{Time.zone.now+1.day}")
    usuario.senha_reset_sent_at = Time.zone.now
    usuario.save
    Mensagem.senha_reset(usuario).deliver_now
  end

end

