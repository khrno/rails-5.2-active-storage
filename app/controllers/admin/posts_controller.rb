class Admin::PostsController < Admin::BaseController
  before_action :load_posts, only: :index
  before_action :load_post, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'The post was created!'
      redirect_to action: 'index'
    else
      render 'index'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Update successful!'
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post destroyed !'
    redirect_to action: 'index'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id, images: [])
  end

  def current_tab
    @current_tab = 'posts'
  end

  def load_posts
    @posts = Post.all
  end

  def load_post
    @post = Post.where(id: params[:id]).take
    not_found unless @post
  end
end