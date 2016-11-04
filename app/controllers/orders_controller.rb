class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @items = @order.items.all
    @status = @order.status
    @ordered_items = @items.group(:id).count
  end

  def create
    @status = Status.where(name: "ordered").first_or_create
    @order = Order.new(user: current_user, status: @status)
    @order_completion = OrderCompletion.new(@order, session[:cart])
    if @order_completion.create
      flash[:success] = "Thank you for placing your order"
      session.delete(:cart)
      redirect_to order_path(@order)
    else
      flash[:alert] = "Order did not submit"
      redirect_to cart_path
    end
  end

  private

  def order_params
    params.require(session[:cart])
  end
end
