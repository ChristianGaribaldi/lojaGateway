require 'cliente_microservico'
class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]
  before_action :set_estados, only: [:new,:edit,:create]

  # GET /clientes
  # GET /clientes.json
  def index
    cliente_microservico = ClienteMicroservico.new
    @clientes = cliente_microservico.ler_clientes
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show
  end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
  end

  # GET /clientes/1/edit
  def edit
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)
    cliente_microservico = ClienteMicroservico.new
    respond_to do |format|
      if cliente_microservico.criar_cliente(@cliente)
        format.html { redirect_to lojas_url, notice: 'Cliente criado com sucesso!' }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1
  # PATCH/PUT /clientes/1.json
  def update
    cliente_microservico = ClienteMicroservico.new
    id = @cliente.id
    cliente_atualizado = Cliente.new(cliente_params)
    cliente_atualizado.id = id

    respond_to do |format|
      if cliente_microservico.atualizar_cliente(cliente_atualizado)
        format.html { redirect_to lojas_url, notice: 'Cliente atualizado com sucesso!' }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    cliente_microservico = ClienteMicroservico.new
    if cliente_microservico.apagar_cliente(@cliente.id)
      respond_to do |format|
        format.html { redirect_to lojas_url, notice: 'Cliente removido com sucesso!' }
        format.json { head :no_content }
      end
    end
  end

  private
  def set_estados
    @estados = Estado.all
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_cliente
    id = params[:id]
    cliente_microservico = ClienteMicroservico.new
    @cliente = cliente_microservico.ler_cliente(id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cliente_params
    params.require(:cliente).permit(:nome, :cpf, :email, :rua, :numero, :bairro, :cidade, :estado, :cep)
  end
end
