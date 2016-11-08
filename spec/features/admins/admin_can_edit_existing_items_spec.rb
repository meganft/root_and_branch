require 'rails_helper'

describe "admin can edit existing item" do
  scenario "admin can edit existing item" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    item = Item.create(title: "old title", description: "old description", image: "old.jpg", retired: false, price: 1.99)

    visit admin_items_path
    click_on "Edit"

    expect(current_path).to eq edit_admin_item_path(item)
    fill_in "item[title]", with: "New title"
    fill_in "item[description]", with: "new description"
    fill_in "item[image]", with: "carrots.jpeg"
    choose "retired"
    click_on "Update Item"

    expect(page).to have_content "New title"
    expect(page).to_not have_content "old title"
  end
end
