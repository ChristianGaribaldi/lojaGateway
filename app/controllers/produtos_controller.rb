require 'produto_microservico'
class ProdutosController < ApplicationController
  before_action :set_produto, only: [:show, :edit, :update, :destroy]

  # GET /produtos
  # GET /produtos.json
  def index
    produto_microservico = ProdutoMicroservico.new
    @produtos = produto_microservico.ler_produtos
  end

  # GET /produtos/1
  # GET /produtos/1.json
  def show
  end

  # GET /produtos/new
  def new
    @produto = Produto.new
  end

  # GET /produtos/1/edit
  def edit
  end

  # POST /produtos
  # POST /produtos.json
  def create
    @produto = Produto.new(produto_params)
    produto_microservico = ProdutoMicroservico.new

    respond_to do |format|
      if produto_microservico.criar_produto(@produto)
        format.html { redirect_to lojas_url, notice: 'Produto criado com sucesso!' }
        format.json { render :show, status: :created, location: @produto }
      else
        format.html { render :new }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produtos/1
  # PATCH/PUT /produtos/1.json
  def update
    produto_microservico = ProdutoMicroservico.new
    id = @produto.id
    produto_atualizado = Produto.new(produto_params)
    produto_atualizado.id = id

    respond_to do |format|
      if produto_microservico.atualizar_produto(produto_atualizado)
        format.html { redirect_to lojas_url, notice: 'Produto atualizado com sucesso!' }
        format.json { render :show, status: :ok, location: @produto }
      else
        format.html { render :edit }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos/1
  # DELETE /produtos/1.json
  def destroy
    produto_microservico = ProdutoMicroservico.new
    if produto_microservico.apagar_produto(@produto.id)
      respond_to do |format|
        format.html { redirect_to lojas_url, notice: 'Produto removido com sucesso!' }
        format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_produto
    id = params[:id]
    produto_microservico = ProdutoMicroservico.new
    @produto = produto_microservico.ler_produto(id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def produto_params
    params.require(:produto).permit(:nome, :descricao, :precoUnitario, :qtd_estoque)
  end
end
