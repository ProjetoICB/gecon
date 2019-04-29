json.extract! conta, :id, :numero, :nome, :observacao, :ativo, :tipo_de_conta_id, :usuario_id, :centro_de_custo_id, :fonte_de_recurso_id, :created_at, :updated_at
json.url conta_url(conta, format: :json)
