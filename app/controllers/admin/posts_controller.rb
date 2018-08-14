class Admin::PostsController < Admin::BaseController
  before_action :load_posts, only: :index

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

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def current_tab
    @current_tab = 'posts'
  end

  def load_posts
    @posts = Post.all
  end
end