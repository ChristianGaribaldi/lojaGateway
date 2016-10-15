class ClienteMicroservico < Microservicos
  def initialize()
    super()
    definir_url("https://cli-mic-christiangaribaldi.c9users.io/clientes/")
  end

  def ler_cliente(id_recurso)
    return trata_resposta_cliente(ler_recurso(id_recurso))
  end

  def ler_clientes()
    return trata_resposta_clientes(ler_recursos)
  end

  def apagar_cliente(id_recurso)
    resposta = apagar_recurso(id_recurso)
    # Código NO_CONTENT= 204
    if resposta.code == 204
      true
    else
      false
    end
  end

  def criar_cliente(novo_recurso)
    resposta = criar_recurso({:cliente => novo_recurso})
    # Código CREATED = 201
    if resposta.code == 201
      true
    else
      false
    end
  end

  def atualizar_cliente(recurso)
    resposta = atualizar_recurso(recurso[:id], {:cliente => recurso})
    # Código NO_CONTENT= 204
    if resposta.code == 204
      true
    else
      false
    end
  end

  def trata_resposta_cliente(resposta)
    if resposta.code == 200
      return cria_cliente(resposta.parse())
    else
      return []
    end
  end

  def  trata_resposta_clientes(resposta)
    if resposta.code == 200
      resposta = resposta.parse()
      clientes = []
      i = 0
      for cliente in resposta
        novo = cria_cliente(cliente)
        clientes[i] = novo
        i+=1
      end
      return clientes
    else
      return []
    end
  end

  private
  def cria_cliente(dados)
    return novo = Cliente.new(id:dados['id'], nome: dados['nome'], cpf: dados['cpf'],
                       email: dados['email'], rua: dados['rua'],
                       numero: dados['numero'], bairro: dados['bairro'],
                       cidade: dados['cidade'], estado: dados['estado'],
                       cep: dados['cep'])
  end
end
