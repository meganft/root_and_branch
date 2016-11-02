class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @items = @order.items.all
    @status = @order.status
  end
end
