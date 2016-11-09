require 'rails_helper'

describe "cart model tests" do
  before :each do
    @cart = Cart.new({"1"=>1})
  end

  scenario "cart can initialize with contents" do

    expect(@cart.contents).to eq({"1"=>1})
  end

  scenario "can add items to contents" do
    @cart.add_item(1)

    expect(@cart.contents).to eq({"1"=>2})
  end

  scenario "add items to empty cart" do
    cart2 = Cart.new(nil)

    cart2.add_item(2)

    expect(cart2.contents).to eq({"2"=>1})
  end

  scenario "can return total number of items in cart" do
    expect(@cart.total_items).to eq(1)

    @cart.add_item(2)

    expect(@cart.total_items).to eq(2)
  end

  scenario "can return total price of one item in cart" do
    item = create(:item)
    cart2 = Cart.new({"#{item.id}"=>1})
    price = item.price

    expect(cart2.total_price).to eq(price)
  end

  scenario "can return total price of all items in cart" do
    item1, item2 = create_list(:item, 2)
    cart3 = Cart.new({"#{item1.id}"=>1, "#{item2.id}"=>1})

    price = item1.price + item2.price
    expect(cart3.total_price).to eq(price)
  end

  scenario "can decrease items in cart" do
    @cart.add_item(1)
    expect(@cart.contents["1"]).to eq(2)

    @cart.decrease_item(1)
    expect(@cart.contents["1"]).to eq(1)
  end

  scenario "can remove item from cart" do
    @cart.remove_item(1)
    expect(@cart.contents).to eq({})
  end
end
