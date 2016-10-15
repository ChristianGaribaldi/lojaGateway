require 'http'
class Microservicos
  @url_base = ''

  protected
  def definir_url(url)
    @url_base = url
  end

  def ler_recurso(id_recurso)
    return Http.get(@url_base +  id_recurso.to_s)
  end

  def ler_recursos()
    return Http.get(@url_base)
  end

  def apagar_recurso(id_recurso)
    return Http.delete(@url_base + id_recurso.to_s)
  end

  def criar_recurso(novo_recurso)
    return Http.post(@url_base, :json => novo_recurso)
  end

  def atualizar_recurso(id_recurso, recurso)
    return Http.put(@url_base + id_recurso.to_s, :json => recurso)
  end
end




