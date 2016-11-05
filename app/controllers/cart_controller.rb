class CartController < ApplicationController

  def show
    @items = @cart.contents
    @total_price = @cart.total_price
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:success] = "Successfully added #{item.title} to your cart."
    redirect_back(fallback_location: cart_path)
  end

  def update
    item = Item.find(params[:item_id])
    @cart.decrease_item(item.id) if params[:change_type] == "decrease"
    @cart.add_item(item.id)      if params[:change_type] == "increase"
    # would need an else to catch any errors??
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
