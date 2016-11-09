require "rails_helper"

describe "dashboard helper filters orders" do
  before :each do
    @user = create(:user)
    @status = Status.create(name: "Ordered")
    @address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: @user.id)
    @status.orders.create(status_id: @status.id, address_id: @address.id, user_id: @user.id)
  end

  it "identifies orders with status 'Ordered'" do
    params = {status: "Ordered", "action"=>"show"}
    orders = DashboardHelper.filter_orders(params)

    expect(orders).to eq(@status.orders)
  end

  it "does not return orders of other status types" do
    status = Status.create(name: "Paid")
    params = {status: "Paid", "action"=>"show"}
    orders = DashboardHelper.filter_orders(params)

    expect(orders).to_not eq(@status.orders)
  end
end
