class AddressesController < ApplicationController

  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.new(address_params) if current_user
    if @address.save
      if current_admin?
        redirect_to admin_dashboard_path
      else
        redirect_to dashboard_path
      end
      flash[:success] = "New address created!"
    else
      flash.now[:error] = "Something went wrong, please try again."
      render :new
    end
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :state, :zip)
  end

end
