class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.all
  end

  def show
    if current_admin?
      @order = Order.find(params[:id])
      @ordered_items = @order.items.group(:id).count
      @user = User.find_by(id: @order.user_id)
    elsif current_user && Order.find(params[:id]).user_id == current_user.id
      @order = current_user.orders.find(params[:id])
      @ordered_items = @order.items.group(:id).count
      @user = current_user
    else
      render file: '/public/404'
    end
  end

  def create
    @status = Status.where(name: "ordered").first_or_create
    @order = Order.new(user: current_user, status: @status, address_id: params[:order][:id])
    @order_completion = OrderCompletion.new(@order, session[:cart])
    if @order_completion.create
      flash[:success] = "Thank you for placing your order"
      session.delete(:cart)
      redirect_to order_path(@order)
    else
      flash[:danger] = "Order did not submit"
      redirect_to cart_path
    end
  end

  private

  def order_params
    params.require(session[:cart]).permit(:address_id)
  end
end
