class CartController < ApplicationController

  def index
    @items = @cart.contents
    @total = @cart.total
  end

  def create
    # binding.pry
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    redirect_to cart_path
  end

end
