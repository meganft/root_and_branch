require 'rails_helper'

describe "admin can log in" do
  scenario "admin can log in and sees admin dashboard" do
    admin = create(:admin)

    visit login_path
    fill_in "email", with: admin.email
    fill_in "password", with: admin.password
    click_button "Login"
    save_and_open_page
    
    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content "Admin Dashboard"
  end

  scenario "default user cannot see admin dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_path

    expect(page).to have_content "The page you were looking for doesn't exist."
  end

  scenario "visitor cannot see admin dashboard" do
    visit admin_dashboard_path
    expect(page).to have_content "The page you were looking for doesn't exist."
  end
end
