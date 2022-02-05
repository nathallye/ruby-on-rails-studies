jobs = {
  'new_post_notification_job' => { # Primeira chave é o nome do job, o valor são os parametros passados dentro de um hash
    'cron' => '0 10 * * 6', # Nesse caso está executando o envio de e-mails de todos os sábados as 10 horas da manhã. Notação do cron: https://crontab.guru/
    'class' => 'NewPostsNotificationJob', 
    'queue' => 'notification', # fila
    'active_job' => true # estamos usando o active job, então o seu valor é => true 
  }
}

Sidekiq::Cron::Job.load_from_hash(jobs) # jobs é a variável que definimos acima (que recebe um hash)