require 'test_helper'

class VendasControllerTest < ActionController::TestCase
  setup do
    @venda = vendas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vendas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create venda" do
    assert_difference('Venda.count') do
      post :create, venda: { cliente_id: @venda.cliente_id, codigo_cartao: @venda.codigo_cartao, desconto: @venda.desconto, num_cartao: @venda.num_cartao, produto_id: @venda.produto_id, quantidade: @venda.quantidade, tipo_pgt: @venda.tipo_pgt, validade_cartao: @venda.validade_cartao, valorVenda: @venda.valorVenda }
    end

    assert_redirected_to venda_path(assigns(:venda))
  end

  test "should show venda" do
    get :show, id: @venda
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @venda
    assert_response :success
  end

  test "should update venda" do
    patch :update, id: @venda, venda: { cliente_id: @venda.cliente_id, codigo_cartao: @venda.codigo_cartao, desconto: @venda.desconto, num_cartao: @venda.num_cartao, produto_id: @venda.produto_id, quantidade: @venda.quantidade, tipo_pgt: @venda.tipo_pgt, validade_cartao: @venda.validade_cartao, valorVenda: @venda.valorVenda }
    assert_redirected_to venda_path(assigns(:venda))
  end

  test "should destroy venda" do
    assert_difference('Venda.count', -1) do
      delete :destroy, id: @venda
    end

    assert_redirected_to vendas_path
  end
end
