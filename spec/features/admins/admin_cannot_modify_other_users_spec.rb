require 'rails_helper'

describe "admin can modify own account data but not other users" do
  scenario "admin can modify own account data" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_on "Edit My Account"

    fill_in "user[email]", with: "newemail@email.com"

    click_on "Update Account"
    admin.reload

    expect(page).to have_content("Successfully updated your account")
    expect(admin.email).to eq("newemail@email.com")
  end

  scenario "admin cannot modify another user's account data" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    user = create(:user)

    visit user_path(user)
    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
