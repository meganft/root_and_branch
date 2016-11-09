module DashboardHelper

  def self.filter_orders(params)
    statuses = ["Ordered", "Paid", "Completed", "Cancelled"]
    if statuses.include?(params[:status])
      status = Status.find_by(name: params[:status])
      status.orders
    else
      Order.all
    end
  end
end
