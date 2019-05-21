json.extract! lancamento, :id, :processo, :data, :datadocumento, :observacao, :debito, :credito, :tipo, :conta_id, :fornecedor_id, :item_de_despesa_id, :item_de_receita_id, :tipo_compra_id, :debito_cancelado, :retorno_debitocanc, :num_notafiscal, :empenho, :created_at, :updated_at
json.url lancamento_url(lancamento, format: :json)
