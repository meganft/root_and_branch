class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cart

  helper_method :current_user
  helper_method :current_admin?
  helper_method :determine_authorization

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def determine_authorization(user)
    if user.admin?
      admin_dashboard_path
    else
      dashboard_path
    end
  end
end
