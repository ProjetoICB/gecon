module LogsHelper


  def addlog(acao)

    @log  = Log.new

    @log.acao = acao
    @log.usuario_id = current_usuario.id
    @log.ip = request.remote_ip

    @log.save!
  end


end
