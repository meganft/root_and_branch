class Admin::DashboardController < Admin::BaseController

  def show
    @orders = Order.all
    @statuses = Order.count_by_status
  end

end
