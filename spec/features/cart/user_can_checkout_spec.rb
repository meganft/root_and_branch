require 'rails_helper'

describe "logged in visitor can checkout" do
  scenario "logged in visitor can checkout from the cart" do
    user = create(:user)
    item = create(:item)
    status = Status.create(name: "ordered")
    address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit item_path(item)
    click_on "Add to cart"

    visit cart_path

    expect(page).to have_button("Checkout")
    select address.street, from: :order_id, visible: false
    click_on "Checkout"

    expect(page).to have_content "Order Status"
    expect(page).to have_content "#{item.title}"
    expect(page).to have_content("Thank you for placing your order")
  end

  scenario "logged in user can checkout with multiple items" do
    user = create(:user)
    item1, item2 = create_list(:item, 2)
    status = Status.create(name: "ordered")
    address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit item_path(item1)
    click_on "Add to cart"
    visit cart_path

    click_on "+"

    visit item_path(item2)
    click_on "Add to cart"
    visit cart_path

    select address.street, from: :order_id, visible: false
    click_on "Checkout"

    expect(page).to have_content "Order Status"
    expect(page).to have_content "#{item1.title}"
    expect(page).to have_content "#{item2.title}"
    expect(page).to have_content("Thank you for placing your order")
  end

  scenario "cart is cleared once checked out" do
    user = create(:user)
    item1, item2 = create_list(:item, 2)
    status = Status.create(name: "ordered")
    address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit item_path(item1)
    click_on "Add to cart"
    visit cart_path

    select address.street, from: :order_id, visible: false
    click_on "Checkout"

    visit cart_path

    expect(page).to_not have_content "#{item1.title}"
    expect(page).to have_content "Total: $0.00"
  end

  scenario "user cannot checkout with no items in cart" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit cart_path

    expect(page).to_not have_content("Checkout")
    expect(current_path).to eq cart_path
  end
end
