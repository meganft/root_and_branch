class CategoriesController < ApplicationController

  def show
    @category = Category.find_by_slug(params[:slug])
    @items = @category.items.all
  end

end
