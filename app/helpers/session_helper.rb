module SessionHelper

  def determine_authorization(user)
    if user.admin?
      admin_dashboard_path
    else
      user_path(user)
    end 
  end

end
