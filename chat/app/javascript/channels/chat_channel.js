import consumer from "./consumer"

const chatChannel = consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log("Connected to the chat room!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // quando a mensagem for recebida essa função vai ser chamada
  received(data) { // recebe os mesmo parâmetro data do speak definido em chat_channel.rb
    $('#messages').append(`<p>${data.author}: ${data.message}</p>`); 
    // #messages' => seleciona o elemento div com o id messages da nossa página html;
    // .append => insere a message no final do array;
    $('html, body').animate({scrollTop:$(document).height()}, 0); // toda vez que recebermos uma mensagem nova o scroll da página vai descendo
  },

  speak: function(data) {
  // essa function recebe como parâmetro o data, que contém o author e a message do formulário que pegamos abaixo, através do jQuery.
    return this.perform('speak', data);
    // this.perform('speak', { message } => . perfome para executar o método speak que definimos no chat_channel.rb para enviar a message; e recebe como parâmetro a o 'data', que é um objeto que contém o author e a message através do submit do formulário que pegamos abaixo, através do jQuery.
  }
});

$(document).on('turbolinks:load', function () { 
  // $(document) => jQuery está pegando o nosso document;
  // turbolinks:load => é algo que o rails utiliza para acelerar o carregamento dos arquivos js dentro do projeto;
  // function () => vamos colocar a seguinte funnção;
  $("#message_form").on('submit', function(e){
    // $("#message_form") => utilizar o jQuery para pegar um elemento do html com o id chamado message_form(formulário que vai enviar mensagem);
    // .on('submit', function(e) => dentro de submit vamos executar essa função e;
    e.preventDefault();
    // e.preventDefault => impedindo que esse formulário seja realmente enviado; paramos o envio fdo formulário quando executamos essa função;

    let data = { // variável data recebe um hash de objetos
      author: $('#author_message').val(),
      // author => essa chave recebe o valor do input com o nome do autor da mensagem que temos lá no formulário na página html que tem o id author_message;
      message: $('#message_to_sent').val()
      // message => essa chave recebe o valor do input com a messagem que temos lá no formulário na página html que tem o id message_to_sent;
    }

    if (data.message.length > 0 && data.author.length > 0) {
    // se o tamanho da mensagem e do author enviado for maior que zero...
      chatChannel.speak(data);
      // chatChannel => vamos utilizar o chatChanel(que colocamos dentro da constante acima);
      // .speak(data) => estamos chamando o método speak dentro do chatChanel e passamos o data como argumento (que contém o objeto com a message e author que salvamos dentro do let data);
      $('#message_to_sent').val('')
      // e por fim, já que enviamos nossa mensagem, passamos/ o valor(alteramos o valor através do jQuery) de message_to_sent vazio.
    }
  });
})