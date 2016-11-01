class SessionsController < ApplicationController

  def index
  end

  def new
  end

  def create
    
  end

  def destroy
    session.delete[:user_id]
    flash[:success] = "You have successfully logged out."
    redirect_to root_path
  end
end
