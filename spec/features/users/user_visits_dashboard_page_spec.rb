require 'rails_helper'

describe "a user visits a dashboard page" do
  scenario "a user visits a dashboard page and sees appropriate information" do

    visit new_user_path

    fill_in "user[name]", with: "Bob"
    fill_in "user[email]", with: "cats@cats.com"
    fill_in "user[password]", with: "cats"
    fill_in "user[password_confirmation]", with: "cats"
    click_button "Create Account"

    expect(page).to have_content("Logged in as #{User.last.name}")
    expect(page).to have_content("#{User.last.email}")
    within(:css, ".float-xs-right") do
      expect(page).to have_content("Logout #{User.last.name}")
      expect(page).to_not have_content("Login")
    end
  end
end
