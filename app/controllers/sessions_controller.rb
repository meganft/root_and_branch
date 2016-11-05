class SessionsController < ApplicationController

  def index
  end

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      if @user.admin?
        flash[:success] = "Successfully logged in as #{@user.name}!"
        session[:user_id] = @user.id
        redirect_to admin_dashboard_path
      else
      flash[:success] = "Successfully logged in as #{@user.name}!"
      session[:user_id] = @user.id
      redirect_to dashboard_path
      end
    else
      flash.now[:error] = "Login failed, please try again."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:cart)
    flash[:success] = "You have successfully logged out."
    redirect_to root_path
  end
end
