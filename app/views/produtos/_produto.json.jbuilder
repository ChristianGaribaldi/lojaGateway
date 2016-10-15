json.extract! produto, :id, :nome, :descricao, :precoUnitario, :qtd_estoque, :created_at, :updated_at
json.url produto_url(produto, format: :json)