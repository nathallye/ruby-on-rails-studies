class ChatChannel < ApplicationCable::Channel
  def subscribed # Esse método vai ser chamado quando alguém ingressar nesse canal
    stream_from "chat_channel" # No do canal: chat_channel
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data) # Recebe o parâmetro data
    ActionCable.server.broadcast('chat_channel', data)
    # ActionCable.server.broadcast => Fazendo um envio através do canal "chat_channel" através do serve(.server) websockts em tempo real/realtime;
    # data => Aqui vamos pegar o data(que é um obj que contém o author e a message) passado dentro do parâmetro "data" ... e enviar através do channel.
  end
end
