class CartController < ApplicationController

  def index
    @items = @cart.contents
    @total = @cart.total
  end

  def create
    
  end

end
