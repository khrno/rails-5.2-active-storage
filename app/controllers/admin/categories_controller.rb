class Admin::CategoriesController < Admin::BaseController
  before_action :load_categories, only: :index

  def index
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to action: 'index', notice: "The category was created!"
    else
      render 'index'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def current_tab
    @current_tab = 'categories'
  end

  def load_categories
    @categories = Category.all
  end
end