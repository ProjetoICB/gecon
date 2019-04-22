class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include LogsHelper
  include SessionHelper

  def autenticado?
    if session[:usuario_id].blank?
      redirect_to root_path, notice: "Faça o login"
      return false
    end
  end

end
