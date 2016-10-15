/**
 * Created by christian on 19/09/16.
 */
function atualizaEndereco(){
    var cep = $( "#cliente_cep").val();
    if(cep != "" && cep.length == 8){
        var url = "https://viacep.com.br/ws/" + cep + "/json/";
        $.ajax({
            url: url ,
            context: document.body
        }).done(function(dados) {
            if(!("erro" in dados)) {
                $("#cliente_rua").val(dados.logradouro);
                $("#cliente_bairro").val(dados.bairro);
                $("#cliente_cidade").val(dados.localidade);
                $("#cliente_estado").val(dados.uf);
                $(".painelEndereco").show();
                $( "#cliente_numero" ).focus();
            }
            else{
                alert("CEP não encontrado! \nTente de novo ou preencha o endereço que tentaremos localizar!");
                $( "#cliente_cep").val("");
                $("#cliente_rua").val("");
                $("#cliente_bairro").val("");
                $("#cliente_cidade").val("");
                $("#cliente_estado").val("");
            }
        }).fail(function() {
            alert("CEP não encontrado!");
            $( "#cliente_cep").val("");
        })
    }
}

function busca_cep(rua, bairro, cidade, estado){
    debugger;
    if(rua != "" && rua.length > 3 && cidade != "" && cidade.length > 3 && estado != ""){
        debugger;
        var url = "https://viacep.com.br/ws/" + estado.trim() + "/" + cidade.trim() + "/" + rua.trim() + "/json/";
        $.ajax({
            url: url ,
            context: document.body
        }).done(function(dados) {
            debugger;
            if(dados.length > 0 ) {
                for (var i = 0; i < dados.length; i++) {
                    if (dados[i].bairro == bairro)
                        $("#cliente_cep").val(dados[i].cep);
                }
            }
            else {
                alert("CEP não encontrado! Dados insuficientes para a busca do CEP.");
                $( "#cliente_cep").val("");
            }
        }).fail(function() {
            alert("CEP não encontrado!");
            $( "#cliente_cep").val("");
        })
    }
}
