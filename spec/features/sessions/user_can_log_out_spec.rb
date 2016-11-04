require "rails_helper"

describe "Logged in user can log out" do
  before :each do
    @user = User.create(name: "Bob", email: "cats@cats.cats", password: "cats")

    visit '/'
    click_on "Login"
    fill_in "email", with: "#{@user.email}"
    fill_in "password", with: "#{@user.password}"
    click_button "Login"

  end
  scenario "they are redirected to the home page" do
    visit cart_path
    click_on "Logout #{@user.name}"

    expect(current_path).to eq '/'
    expect(page).to_not have_content "#{@user.name}"
    expect(page).to have_link("Login", href: login_path)
  end

  scenario "they logout and now have an empty cart" do
    item = create(:item)

    visit item_path(item)
    click_on "Add to cart"

    expect(page).to have_content "Subtotal: $#{item.price}0"
    click_on "Logout #{@user.name}"

    visit cart_path
    expect(page).to_not have_content "Subtotal: $#{item.price}0"
    expect(page).to have_content "Total: $0.00"
  end
end
