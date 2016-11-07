class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
      flash[:success] = "Logged in as #{@user.name}"
    else
      flash.now[:error] = "Please try again."
      render :new
    end
  end

  def show

    @addresses = current_user.addresses.all if current_user
    if !current_user || params[:id] && params[:id] != current_user.id
      render file: '/public/404'
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
