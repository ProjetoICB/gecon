json.extract! transferencia, :id, :data, :datadocumento, :debito_id, :credito_id, :valor, :observacao, :fornecedor_id, :num_notafiscal, :empenho, :created_at, :updated_at
json.url transferencia_url(transferencia, format: :json)
