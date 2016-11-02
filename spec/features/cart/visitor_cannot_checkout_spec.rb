require 'rails_helper'

describe "a visitor visits their cart" do
  scenario "a visitor sees the cart" do
    visit cart_path

    expect(page).to_not have_link("Checkout")

    expect(page).to have_content("Login or Create Account to Checkout")
  end
end
