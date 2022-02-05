class NewPostsNotificationJob < ApplicationJob
  queue_as :notification

  def perform()
    subscribers = [{email: 'joao@gmail.com', name: 'Joao'}, {email: 'lucas@gmail.com', name: 'Lucas'}] # Essa informação pode vir do BD também
    posts = Post.where(published_at: (Time.now - 1.week)..).select(:title)
    # posts: recebe uma coleção de posts, onde esses pots vão ter o published_at(data de publicação) maior ou igual a Time.now(tempo.agora) - 1.week(1.semana) e vão ser selecionados pelo title(.select(:title))
    # )..) - renger, como não vem nada após ele, significa que essa data deve ser maior ou igual uma semana
    subscribers.each do |subscriber| # iterar cada subscriber
      SubscribersMailer.with(subscriber: subscriber, posts: posts)
        .new_posts.deliver_now 
      # Vai ser enviado um email para o SubscribersMailer para informar quais posts foram publicados na ultima semana 
      # with: metodo para enviar os parametros para dentro da action new_post atraves do params hash. Nesse caso, vai receber os params de subscriber: e posts: definidos dentro da action.
      # new_post: action que vai fazer isso, criada dentro do SubscribersMailer;
      # deliver_now: método para enviar o email no exato momento em que ele é chamado.
    end
  end
end
