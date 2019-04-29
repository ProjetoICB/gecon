class SessionController < ApplicationController

  def new
    session[:usuario_id] = nil
  end

  def create
    usuario = Usuario.find_by(email: params[:session][:email].downcase)
    if usuario && usuario.authenticate(params[:session][:password])
      log_in usuario
      redirect_to home_index_path
    else
      render 'new'
      flash.now("Tente outra vez")
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end

end
