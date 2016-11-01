class CartController < ApplicationController

  def index
    @items = @cart.contents
    @total = @cart.total
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
  end

end
