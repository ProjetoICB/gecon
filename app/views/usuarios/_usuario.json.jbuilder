json.extract! usuario, :id, :nome, :email, :password, :tipo, :ativo, :telefone, :departamento_id, :created_at, :updated_at
json.url usuario_url(usuario, format: :json)
