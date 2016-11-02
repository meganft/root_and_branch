require 'rails_helper'

describe "a user can log in" do
  scenario "a user visits login page and logs in" do
    user = User.create(name: "Bob", email: "cats@cats.cats", password: "cats")
    visit login_path

    fill_in "email", with: "#{user.email}"
    fill_in "password", with: "#{user.password}"

    click_button "Login"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Successfully logged in as #{user.name}")
    expect(page).to have_content("#{user.email}")

    within(:css, ".float-xs-right") do
      expect(page).to have_content("Logout")
      expect(page).to_not have_content("Login")
    end
  end

  describe "a user cannot log in" do
    scenario "a user enters an incorrect password" do
      user = User.create(name: "Bob", email: "cats@cats.cats", password: "cats")
      visit login_path

      fill_in "email", with: "#{user.email}"
      fill_in "password", with: "dogs"

      click_button "Login"

      expect(page).to have_content("Login failed, please try again.")

      within(:css, ".float-xs-right") do
        expect(page).to have_content("Login")
        expect(page).to_not have_content("Logout")
      end
    end

    scenario "a user cannot log in with incomplete information" do
      user = User.create(name: "Bob", email: "cats@cats.cats", password: "cats")
      visit login_path

      fill_in "email", with: ""
      fill_in "password", with: "#{user.password}"

      click_button "Login"

      expect(page).to have_content("Login failed, please try again.")

      within(:css, ".float-xs-right") do
        expect(page).to have_content("Login")
        expect(page).to_not have_content("Logout")
      end
    end
  end
end
