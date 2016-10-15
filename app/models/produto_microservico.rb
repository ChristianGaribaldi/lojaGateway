class ProdutoMicroservico < Microservicos

  def initialize()
    super()
    super.definir_url("URL DE Produto")
  end

  def ler_produto(id_recurso)
    return trata_resposta(super.ler_recurso(id_recurso))
  end

  def ler_produtos()
    return trata_resposta(super.ler_recursos())
  end

  def apagar_produto(id_recurso)
    resposta = super.apagar_recurso(id_recurso)
  end

  def criar_produto(novo_recurso)
    resposta = super.criar_recurso(novo_recurso)
  end

  def atualizar_produto(recurso)
    resposta = super.atualizar_recurso(recurso)
  end

  def trata_resposta(resposta)
    if resposta.code == 200
      return trata_resposta_produto(resposta.parse())
    else
      return []
    end
  end

  def  trata_resposta_produto(resposta)
    produtos = []
    i = 0
    for produto in resposta
      novo = Produto.new(nome: produto['nome'], descricao: produto['descricao'],
                         precoUnitario: produto['precoUnitario'], qtd_estoque: produto['qtd_estoque'])
      produtos[i] = novo
      i+=1
    end
    return produtos
  end
end
