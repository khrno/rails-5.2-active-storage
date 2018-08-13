class Admin::PostsController < Admin::BaseController
  def index
  end

  private

  def current_tab
    @current_tab = 'posts'
  end
end