class Admin::CategoriesController < Admin::BaseController
  def initialize
    super
    @current_tab = 'categories'
  end

  def index
  end

  def new
    @category = Category.new
  end
end