class Admin::DashboardController < Admin::BaseController

  def show
    @statuses = Status.left_outer_joins(:orders).select('statuses.*, COUNT(orders.*)').group('statuses.id')
    if params[:status].nil?
      @orders = Order.all
    elsif params[:status] == "Ordered"
      status = Status.find_by(name: "Ordered")
      @orders = status.orders
    elsif params[:status] == "Paid"
      status = Status.find_by(name: "Paid")
      @orders = status.orders
    elsif params[:status] == "Cancelled"
      status = Status.find_by(name: "Cancelled")
      @orders = status.orders
    elsif params[:status] == "Completed"
      status = Status.find_by(name: "Completed")
      @orders = status.orders
    else
      @orders = Order.all
      flash[:alert] = "Filter does not exist"
    end
  end

end
