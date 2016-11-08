class Admin::DashboardController < Admin::BaseController

  def show
    @statuses = Status.left_outer_joins(:orders).select('statuses.*, COUNT(orders.*)').group('statuses.id')
    @orders = DashboardHelper.filter_orders(params)
    if params[:status] && params[:status] != ("Completed" || "Ordered" || "Paid" || "Cancelled")
      flash[:warning] = "Filter does not exist"
    end
  end

  def update
    @order = Order.find(params[:order_id])
    if params[:change_status] == "Cancel"
      status = Status.find_by(name: "Cancelled")
    elsif params[:change_status] == "Paid"
      status = Status.find_by(name: "Paid")
    elsif params[:change_status] == "Completed"
      status = Status.find_by(name: "Completed")
    end
    if @order.update(status_id: status.id)
      flash[:success] = "Your order has been updated to be #{status.name}"
    else
      flash[:danger] = "Your order did not update."
    end
    redirect_to admin_dashboard_path
  end

end
