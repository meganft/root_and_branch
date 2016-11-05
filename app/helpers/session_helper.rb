module SessionHelper

  def determine_authorization(user)
    if user.admin?
      admin_dashboard_path
    else
      dashboard_path
    end
  end

end
