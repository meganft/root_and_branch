require 'rails_helper'

describe "a visitor can create an account" do
  scenario "a visitor visits login path and clicks on create account" do
    visit login_path

    click_on "Create Account"

    expect(current_path).to eq(new_user_path)
  end

  scenario "a visitor can create an account" do
    visit new_user_path

    fill_in "user[name]", with: "Bob"
    fill_in "user[email]", with: "cats@cats.com"
    fill_in "user[password]", with: "cats"
    fill_in "user[password_confirmation]", with: "cats"
    click_button "Create Account"

    expect(current_path).to eq(dashboard_path)
  end

  scenario "a visitor cannot create an account without password" do
    visit new_user_path

    fill_in "user[name]", with: "Bob"
    fill_in "user[email]", with: "cats@cats.com"
    click_button "Create Account"

    expect(current_path).to_not eq(login_path)
    expect(page).to have_content("Please try again.")
  end

  scenario "a visitor cannot create an account without password confirmation" do
    visit new_user_path

    fill_in "user[name]", with: "Bob"
    fill_in "user[email]", with: "cats@cats.com"
    fill_in "user[password]", with: "cats"
    click_button "Create Account"

    expect(current_path).to_not eq(login_path)
    expect(page).to have_content("Please try again.")
  end

  scenario "a visitor cannot create an account with password not matching password confirmation" do
    visit new_user_path

    fill_in "user[name]", with: "Bob"
    fill_in "user[email]", with: "cats@cats.com"
    fill_in "user[password]", with: "cats"
    fill_in "user[password_confirmation]", with: "dogs"
    click_button "Create Account"

    expect(current_path).to_not eq(login_path)
    expect(page).to have_content("Please try again.")
  end

  scenario "a visitor cannot create an account without a unique email" do
    user = create(:user)

    visit new_user_path

    fill_in "user[name]", with: "Bob"
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: "cats"
    fill_in "user[password_confirmation]", with: "cats"
    click_button "Create Account"

    expect(current_path).to_not eq(login_path)
    expect(page).to have_content("Please try again.")
  end
end
