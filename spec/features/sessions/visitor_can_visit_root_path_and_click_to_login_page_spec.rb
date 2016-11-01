require 'rails_helper'

describe "a visitor visits root path" do
  scenario "a visitor visits root path and clicks login button" do
    visit root_path

    click_on "Login"

    expect(current_path).to eq(login_path)
  end
  scenario "a visitor sees login page" do
    visit login_path

    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    # expect(page).to have_link("Create Account", new_user_path)
  end
end
