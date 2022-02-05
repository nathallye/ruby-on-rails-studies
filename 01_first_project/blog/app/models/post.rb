class Post < ApplicationRecord
  after_create :send_new_post_email # esse calback vai ser executado depois da criação de um novo post (callback de uma action para envio de e-mail)

  validates :title, presence: true, length: { minimum: 3, maximum: 200 }

  belongs_to :author # pertence a 

  def send_new_post_email # definição do callback
    PostMailer.with(post: self).new_post.deliver_now
    # PostMailer: classe para envio de emails do mailer que foi criado;
    # with: metodo para enviar os parametros para dentro da action new_post atraves do params hash. Self é igual ao próprio objeto... na hora que estivermos executando esse objeto dentro do model, ele o post que vai ser criado;
    # new_post: action que vai fazer isso, criada dentro do PostMailer;
    # deliver_now: método para enviar o email no exato momento em que ele é chamado.
  end
end
