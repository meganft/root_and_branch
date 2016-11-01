require 'rails_helper'

describe "visitor adds items to cart" do
  scenario "they select an item from category page" do
    category = create(:item_on_category)
    item1, item2 = category.items

    visit category_path(category)

    within(".item_#{item1.id}") do
      click_on "Add to cart"
    end
    click_on "Cart"

    expect(current_path).to eq cart_path
    expect(page).to have_content item1.title
    expect(page).to have_content item1.description
    expect(page).to have_content item1.price
    expect(page).to have_css "img[src*='#{item1.image}']"
    expect(page).to have_content item1.price
  end

  scenario "they visit the cart without items" do
    item = create(:item)

    visit cart_path

    expect(current_path).to eq cart_path
    expect(page).to_not have_content item.title
    expect(page).to have_content "Total: 0"
  end

  scenario "they add multiple items to a cart" do
    category = create(:item_on_category)
    item1, item2 = category.items

    visit category_path(category)
    within(".item_#{item1.id}") do
      click_on "Add to cart"
    end
    visit category_path(category)
    within(".item_#{item2.id}") do
      click_on "Add to cart"
    end
    total_price = item1.price + item2.price

    expect(page).to have_content item1.title
    expect(page).to have_content item2.title
    expect(page).to have_content "Total: #{total_price}"
  end

end
