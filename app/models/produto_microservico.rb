class ProdutoMicroservico < Microservicos
  def initialize()
    super()
    definir_url("https://pro-mic-christiangaribaldi.c9users.io/produtos/")
  end

  def ler_produto(id_recurso)
    return trata_resposta_produto(ler_recurso(id_recurso))
  end

  def ler_produtos()
    return trata_resposta_produtos(ler_recursos())
  end

  def apagar_produto(id_recurso)
    resposta = apagar_recurso(id_recurso)
    # Código NO_CONTENT= 204
    if resposta.code == 204
      true
    else
      false
    end
  end

  def criar_produto(novo_recurso)
    resposta = criar_recurso({:produto => novo_recurso})
    # Código CREATED = 201
    if resposta.code == 201
      true
    else
      false
    end
  end

  def atualizar_produto(recurso)
    resposta = atualizar_recurso(recurso[:id], {:produto => recurso})
    # Código NO_CONTENT= 204
    if resposta.code == 204
      true
    else
      false
    end
  end

  def trata_resposta_produto(resposta)
    if resposta.code == 200
      return cria_produto(resposta.parse())
    else
      return []
    end
  end

  def trata_resposta_produtos(resposta)
    if resposta.code == 200
      resposta = resposta.parse()
      produtos = []
      i = 0
      for produto in resposta
        novo = cria_produto(produto)
        produtos[i] = novo
        i+=1
      end
      return produtos
    else
      return []
    end
  end

  private
  def cria_produto(dados)
    return novo = Produto.new(id: dados['id'], nome: dados['nome'], descricao: dados['descricao'],
                                     precoUnitario: dados['precoUnitario'], qtd_estoque: dados['qtd_estoque'])
  end
end


