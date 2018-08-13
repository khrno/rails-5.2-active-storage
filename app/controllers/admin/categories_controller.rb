class Admin::CategoriesController < Admin::BaseController
  before_action :load_categories, only: :index
  before_action :load_category, only: [:edit, :update]

  def index
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'The cateogry was created!'
      redirect_to action: 'index'
    else
      render 'index'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = 'Update successful!'
      redirect_to action: 'index'
    else
      render 'edit'
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

  def load_category
    @category = Category.where(id: params[:id]).take
    not_found unless @category
  end
end