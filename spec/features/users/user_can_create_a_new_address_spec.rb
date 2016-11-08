require 'rails_helper'

describe "A user can create a new address" do
  scenario "a user creates a new address" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_address_path

    fill_in "address[street]", with: "100 Main Street"
    fill_in "address[city]", with: "Denver"
    fill_in "address[state]", with: "CO"
    fill_in "address[zip]", with: 80209

    click_button "Create Address"

    expect(current_path).to eq(cart_path)
    expect(page).to have_content("New address created!")
    expect(page).to have_content("100 Main Street")
  end
end
