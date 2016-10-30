/**
 * Created by christian on 26/09/16.
 */

function adiciona_produto_carrinho(evento){
    var botao = evento.currentTarget;
    var id_produto = $(botao).val();

    //Desabilita botão de adicionar do produto clicado
    $(botao).prop("disabled",true);

    //Cópia da Linha de Estoque
    var seletor_linha = "#linha_estoque_" + id_produto;
    var copia = $(seletor_linha).clone();

    var nome = copia.find(".nome").html();
    var preco = copia.find(".preco").html();

    var nova_linha =
        "<tr id='linha_carrinho_"+ id_produto +"'>" +
            "<td class='nome'>" + nome +" </td>" +
            "<td class='preco'>" + preco +" </td>" +
            "<td> <span class='col-md-10'>" +
                    "<input name='venda[produto_id][]' value='" + id_produto + "' type='hidden'/>" +
                    "<input name='venda[quantidade][]' value='1' type='number' class='form-control' min='1' step='1'/> </span> " +
            "</td>" +
            "<td><button id='bt_remove_" + id_produto +"' value='"+ id_produto +"' class='btn btn-danger btn-sm'>" +
                    "<span class='glyphicon glyphicon-remove' aria-hidden='true'></span>"+
                "</button>" +
            "</td>" +
        "</tr>";

    $(".lista_carrinho:last").append(nova_linha);

    //Adiciono manipulador de evento ao novo botão de Remover do Carrinho
    $("[id*='bt_remove_']" ).on("click",function(event) {
        event.preventDefault();
        remove_produto_carrinho(event);
        calcula_valor_carrinho();
    });

    //Adiciono manipulador de evento ao novo campo 'Quantidade'.
    $("[name*='quantidade']" ).on("change",function(event) {
        event.preventDefault();
        calcula_valor_carrinho();
    });
}

function remove_produto_carrinho(evento){
    var botao = evento.currentTarget;
    var id_produto = $(botao).val();

    //Habilita botão de adicionar do produto removido do carrinho
    var seletor_botao = "#bt_add_" + id_produto;
    $(seletor_botao).prop("disabled",false);

    //Remove produto do carrinho
    var seletor_linha = "#linha_carrinho_" + id_produto;
    $(seletor_linha).remove();
}

function calcula_valor_carrinho(){
    var valor_total = 0;
    $(".lista_carrinho").children().each(function(index,elemento){
        var qtd = $(elemento).find("[name*='quantidade']").val();
        var preco = $(elemento).find(".preco").text();
        if(qtd == "" || preco == "") valor_total+=0;
        else valor_total+= qtd * preco;
    });

    // Calcula Valor Total com desconto
    var desconto = $("#desconto").val();
    if(desconto != "") valor_total *= (1 - (desconto/100));

    // Exibe Valor Total
    valor_total = valor_total.toFixed(2);
    $("#valor_total").text(valor_total);
}
