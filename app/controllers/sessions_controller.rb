class SessionsController < ApplicationController
  include SessionHelper

  def index
  end

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      flash[:success] = "Successfully logged in as #{@user.name}!"
      session[:user_id] = @user.id
      redirect_to determine_authorization(@user)
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
