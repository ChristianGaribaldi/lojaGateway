require 'http'
class Microservicos
  @url_base = ''

  def definir_url(url)
    @url_base = url
  end

  def ler_recurso(id_recurso)
    return Http.get(@url_base +  id_recurso)
  end

  def ler_recursos()
    return Http.get(@url_base)
  end

  def apagar_recurso(id_recurso)
    return Http.delete(@url_base + id_recurso)
  end

  def criar_recurso(novo_recurso)
    return Http.post(@url_base, :json => novo_recurso)
  end

  def atualizar_recurso(recurso)
    return Http.put(@url_base + recurso[:id], :params => recurso)
  end
end




