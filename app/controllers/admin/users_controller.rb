class Admin::UsersController < Admin::BaseController

  def edit
    @user = current_user if current_admin?
  end

  def update
    @user = User.find_by(id: current_user.id)
    if @user.update(admin_params)
      flash[:success] = "Successfully updated your account"
      redirect_to admin_dashboard_path

    else
      flash.now[:error] = "Please try again"
      render :edit
    end
  end

private

  def admin_params
    params.require(:user).permit(:name, :email)
  end
end
