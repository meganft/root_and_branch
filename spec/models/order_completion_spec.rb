require 'rails_helper'

describe "an order is completed" do
  before :each do
    @user = create(:user)
    @status = Status.create(name: "Ordered")
    @address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: @user.id)
    @order = Order.create(status_id: @status.id, address_id: @address.id, user_id: @user.id)
    @item = create(:item)
  end

  it "add_items_to_order adds an item to an order" do
    cart = {"#{@item.id}" => 1}
    complete = OrderCompletion.new(@order, cart)
    complete.create

    expect(complete.cart).to eq({"#{@item.id}" => 1})
    expect(complete.order.items.count).to eq(1)
  end

  it "order is not completed if cart is nil" do
    complete = OrderCompletion.new(@order, nil)

    expect(complete.create).to_not be_truthy
  end




end
