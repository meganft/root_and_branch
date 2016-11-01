require 'rails_helper'

describe "a visitor visits items index" do
  scenario "they see all the items" do
    item1, item2, item3 = create_list(:item, 3)

    visit items_path

    expect(page).to have_content item1.title
    expect(page).to have_content "$#{item1.price}0"
    expect(page).to have_css "img[src*='#{item1.image}']"

    expect(page).to have_content item2.title
    expect(page).to have_content "$#{item2.price}0"
    expect(page).to have_css "img[src*='#{item2.image}']"

    expect(page).to have_content item3.title
    expect(page).to have_content "$#{item3.price}0"
    expect(page).to have_css "img[src*='#{item3.image}']"
  end
end
