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
    @status = Status.find_by(name: "ordered")
    @order = Order.new(user: current_user, status: @status)
    if @order.save
      session[:cart].each do |id, quantity|
        item = Item.find(id)
        quantity.times do
          @order.items << item
        end
      end
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
