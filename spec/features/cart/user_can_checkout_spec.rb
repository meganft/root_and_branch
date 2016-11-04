require 'rails_helper'

describe "logged in visitor can checkout" do
  scenario "logged in visitor can checkout from the cart" do
    user = create(:user)
    item = create(:item)
    status = Status.create(name: "ordered")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit item_path(item)
    click_on "Add to cart"

    expect(page).to have_link("Checkout", href: orders_path)
    click_on "Checkout"

    expect(page).to have_content "Order Status"
    expect(page).to have_content "#{item.title}"
    expect(page).to have_content("Thank you for placing your order")
  end

  scenario "logged in user can checkout with multiple items" do
    user = create(:user)
    item1, item2 = create_list(:item, 2)
    status = Status.create(name: "ordered")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit item_path(item1)
    click_on "Add to cart"

    click_on "+"

    visit item_path(item2)
    click_on "Add to cart"

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

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit item_path(item1)
    click_on "Add to cart"

    click_on "Checkout"

    visit cart_path

    expect(page).to_not have_content "#{item1.title}"
    expect(page).to have_content "Total: $0.00"
  end
end
