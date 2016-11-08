module DashboardHelper

  def self.filter_orders(params)
    # binding.pry if params[:status]
    # if params[:status] != ("Ordered" || "Paid" || "Completed" || "Cancelled")
    statuses = ["Ordered", "Paid", "Completed", "Cancelled"]
    if statuses.include?(params[:status])
      status = Status.find_by(name: params[:status])
      status.orders
    else
      Order.all
    end
  end

  # def find_status(params[:status])
  #   Status.find_by(name: )
  # end

  def self.find_ordered
    status = Status.find_by(name: "Ordered")
    status.orders
  end

  def self.find_paid
    status = Status.find_by(name: "Paid")
    status.orders
  end

  def self.find_cancelled
    status = Status.find_by(name: "Cancelled")
    status.orders
  end

  def self.find_completed
    status = Status.find_by(name: "Completed")
    status.orders
  end

  def self.unknown_filter
    Order.all
  end

end
