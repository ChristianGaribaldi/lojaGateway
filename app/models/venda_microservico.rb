class VendaMicroservico < Microservicos
  def initialize()
    super()
    definir_url("https://ven-mic-christiangaribaldi.c9users.io/vendas/")
  end

  def ler_venda(id_recurso)
    return trata_resposta_venda(ler_recurso(id_recurso))
  end

  def ler_vendas()
    return trata_resposta_vendas(ler_recursos)
  end

  def apagar_venda(id_recurso)
    resposta = apagar_recurso(id_recurso)
    # Código NO_CONTENT= 204
    if resposta.code == 204
      true
    else
      false
    end
  end

  def criar_venda(novo_recurso)
    resposta = criar_recurso({:venda => novo_recurso})
    # Código CREATED = 201
    if resposta.code == 201
      true
    else
      false
    end
  end

  def atualizar_venda(recurso)
    resposta = atualizar_recurso(recurso[:id], {:venda => recurso})
    # Código NO_CONTENT= 204
    if resposta.code == 204
      true
    else
      false
    end
  end

  def trata_resposta_venda(resposta)
    if resposta.code == 200
      return cria_venda(resposta.parse())
    else
      return []
    end
  end

  def  trata_resposta_vendas(resposta)
    if resposta.code == 200
      resposta = resposta.parse()
      vendas = []
      i = 0
      for venda in resposta
        novo = cria_venda(venda)
        vendas[i] = novo
        i+=1
      end
      return vendas
    else
      return []
    end
  end

  private
  def cria_venda(dados)
    return novo = Venda.new(id:dados['id'], produto_id: dados['produto_id'], cliente_id: dados['cliente_id'],
                              quantidade: dados['quantidade'], valorVenda: dados['valorVenda'],
                              tipo_pgt: dados['tipo_pgt'], num_cartao: dados['num_cartao'],
                              validade_cartao: dados['validade_cartao'], codigo_cartao: dados['codigo_cartao'],
                              desconto: dados['desconto'])
  end
end


