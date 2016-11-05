require 'rails_helper'

describe "an unauthenticated user can only see permitted information" do
  scenario "an unauthenticated user cannot view another user's private data" do
    user1 = create(:user)

    visit user_path(user1)

    expect(page).to_not have_content(user1.name)
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit dashboard_path

    expect(page).to_not have_content(user1.name)
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "an unauthenticated user cannot view admin page" do

    visit admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
