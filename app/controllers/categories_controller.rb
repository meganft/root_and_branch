class CategoriesController < ApplicationController

  def show
    @category = Category.find_by_slug(params[:slug])
    @items = @category.items.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "New category #{@category.name} created!"
      redirect_to category_path(@category)
    else
      flash.now[:error] = "Category failed to save"
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
