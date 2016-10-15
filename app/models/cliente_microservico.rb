class ClienteMicroservico < Microservicos
  def initialize()
    super()
    definir_url("https://cli-mic-christiangaribaldi.c9users.io/clientes/")
  end

  def ler_cliente(id_recurso)
    return trata_resposta(ler_recurso(id_recurso))
  end

  def ler_clientes()
    return trata_resposta(ler_recursos)
  end

  def apagar_cliente(id_recurso)
    return resposta = apagar_recurso(id_recurso)
  end

  def criar_cliente(novo_recurso)
    resposta = criar_recurso({:cliente => novo_recurso})
  end

  def atualizar_cliente(recurso)
    resposta = atualizar_recurso(recurso)
  end

  def trata_resposta(resposta)
    if resposta.code == 200
      return trata_resposta_cliente(resposta.parse())
    else
      return []
    end
  end

  def  trata_resposta_cliente(resposta)
    clientes = []
    i = 0
    for cliente in resposta
      novo = Cliente.new(nome: cliente['nome'], cpf: cliente['cpf'],
                         email: cliente['email'], rua: cliente['rua'],
                         numero: cliente['numero'], bairro: cliente['bairro'],
                         cidade: cliente['cidade'], estado: cliente['estado'],
                         cep: cliente['cep'])
      clientes[i] = novo
      i+=1
    end
    return clientes
  end
end
