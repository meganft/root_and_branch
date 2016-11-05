require 'rails_helper'

describe "admin can log in" do
  scenario "admin can log in and sees admin dashboard" do
    admin = create(:admin)

    visit login_path
    fill_in "email", with: admin.email
    fill_in "password", with: admin.password
    click_button "Login"

    expect(current_path).to eq("/admin/dashboard")
  end
end
