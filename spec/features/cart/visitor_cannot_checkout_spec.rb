require 'rails_helper'

describe "a visitor visits their cart" do
  scenario "a visitor sees the cart" do
    item = Item.create(title: "cat sweater", price: 49.99, description: "beautiful cat sweater", image: "sweater.jpg")

    visit items_path

    click_on "Add to cart"

    visit cart_path

    expect(page).to_not have_link("Checkout")

    expect(page).to have_content("Login or Create Account to Checkout")
    expect(page).to have_content("cat sweater")
  end

  scenario "visitor creates an account and sees the cart" do
    item = Item.create(title: "cat sweater", price: 49.99, description: "beautiful cat sweater", image: "sweater.jpg")

    visit items_path

    click_on "Add to cart"

    visit new_user_path

    fill_in "user[name]", with: "Bob"
    fill_in "user[email]", with: "cats@cats.com"
    fill_in "user[password]", with: "cats"
    fill_in "user[password_confirmation]", with: "cats"
    click_button "Create Account"

    visit cart_path

    expect(page).to have_content("cat sweater")
    expect(page).to have_content("Logout")

    click_on "Logout Bob"

    expect(page).to have_content("Login")
    expect(page).to_not have_content("Logout")
  end
end
