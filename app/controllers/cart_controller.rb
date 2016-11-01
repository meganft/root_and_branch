class CartController < ApplicationController

  def index
    @items = @cart.contents
    @total_price = @cart.total_price
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    redirect_to cart_path
  end

  def destroy
    item = Item.find(params[:item_id])
    @cart.remove_item(item.id)
    flash[:success] = "Successfully removed #{view_context.link_to item.title, item_path(item)} from cart."
    session[:cart] = @cart.contents 
    redirect_to cart_path
  end

end
