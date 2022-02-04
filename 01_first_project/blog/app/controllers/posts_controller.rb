class PostsController < ApplicationController
  layout 'post' # Todas as actions do controller post vão utilizar esse layout
  before_action :set_post, only: %i[show edit update destroy] # Callback de controller: esse calback deve ser executado antes de uma ou mais actions

  def index
    @posts = Post.all  
    render layout: "application" # Somente a action index vai utilizar esse layout diferente(o padrão application.html)
  end

  def show
  end

  def new
    @post = Post.new # A variável de instância vai receber a criação de um novo objeto Post(Post.new)
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
      
    if @post.save
      redirect_to '/posts'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to '/posts'
    else
      render :edit
    end
  end
  
  def destroy
  end


  private 

  def set_post #Definição do método (callback )
    @post = Post.find(params[:id]) # Vai procurar um post para atribuir a variável de instância @post. Todas as actions definidas no callback vão poder acessar essa variável de instância.
  end

  def post_params
    params.require(:post).permit(:title, :content, :published_at, :author_id)
  end
  
end


