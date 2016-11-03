require 'rails_helper'

describe "logged in visitor can checkout" do
  scenario "logged in visitor can checkout from the cart" do
    user = create(:user)
    item = create(:item)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit item_path(item)
    click_on "Add to cart"

    expect(page).to have_link("Checkout", href: orders_path)
    click_on "Checkout"

    expect(page).to have_content("Thank you for placing your order")
  end
end
