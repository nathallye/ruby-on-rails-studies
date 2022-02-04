Rails.application.routes.draw do
  resources :authors
  resources :posts # resources pois temos todas as rotas para criar um CRUD, e como temos todas essas rotas, podemos definir tudo isso com essa instrução, e o rails vai se encarregar de criar todas as rotas(ao invés de fazermos uma a uma manualmente)
  
  get '/site', to: 'site#index'
  root to: 'site#index'
end
