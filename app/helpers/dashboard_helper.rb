module DashboardHelper

  def filter_orders(params)
    if params[:status].nil?
      @orders = Order.all
    elsif params[:status] == "Ordered"
      find_ordered
    elsif params[:status] == "Paid"
      find_paid
    elsif params[:status] == "Cancelled"
      find_cancelled
    elsif params[:status] == "Completed"
      find_completed
    else
      unknown_filter
    end
  end

  def find_ordered
    status = Status.find_by(name: "Ordered")
    @orders = status.orders
  end

  def find_paid
    status = Status.find_by(name: "Paid")
    @orders = status.orders
  end

  def find_cancelled
    status = Status.find_by(name: "Cancelled")
    @orders = status.orders
  end

  def find_completed
    status = Status.find_by(name: "Completed")
    @orders = status.orders
  end

  def unknown_filter
    @orders = Order.all
    flash[:warning] = "Filter does not exist"
  end

end
