class SessionController < ApplicationController

  def new
    session[:usuario_id] = nil
  end

  def create
    usuario = Usuario.find_by(email: params[:session][:email].downcase)


    if usuario && usuario.ativo == false
      flash.now[:notice] = "Você não tem permissão para acessar esse sistema"
      render 'new'
    elsif usuario && usuario.authenticate(params[:session][:password])
      log_in usuario
      redirect_to home_index_path
    else
      flash.now[:notice] = "Usuário ou senha inválidos"
      render 'new'
    end
  end


  def destroy
    log_out
    redirect_to login_path
  end

end
