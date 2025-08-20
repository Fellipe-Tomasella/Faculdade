// Quando o formulário for enviado
document.getElementById('formulario').addEventListener('submit', function(e) {
    e.preventDefault();

    // Pegar os dados do formulário
    var nome = document.getElementById('nome').value;
    var email = document.getElementById('email').value;
    var telefone = document.getElementById('telefone').value;
    var observacao = document.getElementById('observacao').value;

    // Colocar os dados na tabela
    var corpoTabela = document.getElementById('corpo-tabela');
    corpoTabela.innerHTML = '<tr>' +
        '<td>' + nome + '</td>' +
        '<td>' + email + '</td>' +
        '<td>' + telefone + '</td>' +
        '<td>' + observacao + '</td>' +
    '</tr>';

    // Esconder formulário e mostrar tabela
    document.getElementById('caixa-formulario').style.display = 'none';
    document.getElementById('caixa-tabela').style.display = 'block';
});

// Quando clicar no botão voltar
document.getElementById('botaoVoltar').addEventListener('click', function() {
    // Esconder tabela e mostrar formulário
    document.getElementById('caixa-formulario').style.display = 'block';
    document.getElementById('caixa-tabela').style.display = 'none';
});