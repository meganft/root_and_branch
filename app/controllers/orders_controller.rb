class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @items = @order.items.all
    @status = @order.status
  end

  def create
    binding.pry
    @order = Order.new(order_params)
    if @order.save
      flash[:success] = "Thank you for placing your order"
      redirect_to order_path(@order)
    else
      redirect_to cart_path
    end
  end

  private

  def order_params
    params.require(session[:cart])
  end
end
