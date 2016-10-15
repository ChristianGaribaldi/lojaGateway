class VendaMicroservico < Microservicos
  def initialize()
    super()
    super.definir_url("URL DE Venda")
  end

  def ler_venda(id_recurso)
    resposta = super.ler_recurso(id_recurso)
  end

  def ler_vendas()
    resposta = super.ler_recursos()
  end

  def apagar_venda(id_recurso)
    resposta = super.apagar_recurso(id_recurso)
  end

  def criar_venda(novo_recurso)
    resposta = super.criar_recurso(novo_recurso)
  end

  def atualizar_venda(recurso)
    resposta = super.atualizar_recurso(recurso)
  end

end