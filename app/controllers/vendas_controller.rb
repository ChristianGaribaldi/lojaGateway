require 'venda_microservico'
class VendasController < ApplicationController
  before_action :set_venda, only: [:show, :edit, :update, :destroy]
  before_action :set_produtos_clientes, only: [:new,:edit,:create]

  # GET /vendas
  # GET /vendas.json
  def index
    venda_microservico = VendaMicroservico.new
    vendas_totais = venda_microservico.ler_vendas
    @produtos_vendidos = {}
    @qtd_total = {}
    @valor_total = {}

    if !vendas_totais.empty?
      for venda in vendas_totais
        if @produtos_vendidos[venda.produto_id].nil?
          produto = ProdutoMicroservico.new.ler_produto(venda.produto_id)
          @produtos_vendidos[venda.produto_id] = produto.nome
          @qtd_total[produto.nome] = venda.quantidade
          @valor_total[produto.nome] = venda.valorVenda
        else
          nome = @produtos_vendidos[venda.produto_id]
          @qtd_total[nome] += venda.quantidade
          @valor_total[nome] += venda.valorVenda
        end
      end
    end
  end

  # GET /vendas/1
  # GET /vendas/1.json
  def show
  end

  # GET /vendas/new
  def new
    @venda = Venda.new
  end

  # GET /vendas/1/edit
  def edit
  end

  # POST /vendas
  # POST /vendas.json
  def create
    cliente_id = params[:venda][:cliente_id]
    desconto = params[:venda][:desconto].to_f
    opcao_pgt = params[:opcaoPgt]
    @venda = Venda.new

    cont = 0
    erros = false
    if !params[:venda][:produto_id].nil?
      for produto in params[:venda][:produto_id]
        produto_existente = ProdutoMicroservico.new.ler_produto(produto)
        preco_unitario = produto_existente.precoUnitario
        qtd = params[:venda][:quantidade][cont].to_i
        valor_venda = qtd * preco_unitario
        valor_venda *= (1 - (desconto/100))
        valor_venda = valor_venda.round(2)

        if opcao_pgt != "Dinheiro"
          num_cartao = params[:venda][:num_cartao]
          validade_cartao = params[:venda][:valid_cartao]
          codigo_cartao = params[:venda][:cvv_cartao]
          venda = Venda.new(cliente_id: cliente_id, produto_id: produto, quantidade: qtd, valorVenda: valor_venda, tipo_pgt: opcao_pgt,
                            desconto: desconto, num_cartao: num_cartao, validade_cartao: validade_cartao, codigo_cartao: codigo_cartao)
        else
          venda = Venda.new(cliente_id: cliente_id, produto_id: produto, quantidade: qtd, valorVenda: valor_venda,
                            tipo_pgt: opcao_pgt, desconto: desconto)
        end
        salvar = VendaMicroservico.new.criar_venda(venda)
        if  salvar != true
          erros = true
          @venda.errors.add(:base, salvar['base'].to_s.gsub('[','').gsub(']',''))
        end
        cont+= 1
      end

      respond_to do |format|
        if erros
          format.html { render :new }
        else
          format.html { redirect_to lojas_url, notice: 'Venda realizada com sucesso!' }
        end
      end
    else
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /vendas/1
  # PATCH/PUT /vendas/1.json
  def update
    respond_to do |format|
      if @venda.update(venda_params)
        format.html { redirect_to @venda, notice: 'Venda was successfully updated.' }
        format.json { render :show, status: :ok, location: @venda }
      else
        format.html { render :edit }
        format.json { render json: @venda.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendas/1
  # DELETE /vendas/1.json
  def destroy
    @venda.destroy
    respond_to do |format|
      format.html { redirect_to vendas_url, notice: 'Venda was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_venda
    @venda = Venda.find(params[:id])
  end

  def set_produtos_clientes
    @clientes = ClienteMicroservico.new.ler_clientes
    @produtos = ProdutoMicroservico.new.ler_produtos.find_all {|item| item.qtd_estoque > 0 }
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def venda_params
    params.require(:venda).permit(:produto_id, :cliente_id, :quantidade, :valorVenda, :tipo_pgt, :num_cartao, :validade_cartao, :codigo_cartao, :desconto)
  end
end
