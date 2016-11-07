class Admin::DashboardController < Admin::BaseController
  include DashboardHelper

  def show
    @statuses = Status.left_outer_joins(:orders).select('statuses.*, COUNT(orders.*)').group('statuses.id')
    filter_orders(params)
  end

end
