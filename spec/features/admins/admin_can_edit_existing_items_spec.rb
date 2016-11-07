require 'rails_helper'

describe "admin can edit existing item" do
  scenario "admin can edit existing item" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    item = Item.create(title: "old title", description: "old description", image: "old.jpg", retired: false, price: 1.99)

    visit admin_items_path
    click_on "Edit"

    expect(current_path).to eq edit_admin_item_path(item)
    fill_in "title", with: "New title"
    fill_in "description", with: "new description"
    fill_in "image", with: "carrots.jpeg"
    select "False", from: "retired"
    click_on "Update item"

    expect(page).to have_content "New title"
    expect(page).to_not have_content "old title"
  end
end
