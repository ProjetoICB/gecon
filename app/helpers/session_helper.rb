module SessionHelper

  def log_in(usuario)
    session[:usuario_id] = usuario.id
    session[:usuario_email] = usuario.email
    session[:usuario_tipo] = usuario.tipo
  end

  def log_out
    session.destroy
    @current_usuario = nil
  end

  def current_usuario
    @current_usuario ||= Usuario.find_by(id: session[:usuario_id])
  end

  def logged_in
    !current_usuario.nil?
  end
end
