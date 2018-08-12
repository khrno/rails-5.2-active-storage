class Admin::PostsController < Admin::BaseController
  def initialize
    super
    @current_tab = 'posts'
  end

  def index
  end
end