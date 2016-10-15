json.extract! cliente, :id, :nome, :cpf, :email, :rua, :numero, :bairro, :cidade, :estado, :cep, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)