require 'rails_helper'

describe "a user visits an item show page of a retired item" do
  scenario "a user cannot add retired item to cart" do
    item = Item.create(title: "cat sweater", description: "fuzzy", price: 5.75, image: "cat.jpg", retired: true)

    visit item_path(item)

    expect(page).to_not have_link("Add to Cart")
    expect(page).to have_content("Sorry, this item is retired")
  end
end
