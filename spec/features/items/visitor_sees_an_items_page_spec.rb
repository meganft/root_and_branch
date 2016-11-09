require 'rails_helper'

describe "they visit an item page" do
  before :each do
    @item = create(:item)
    visit item_path(@item)
  end

  scenario "they see an item's details" do
    expect(page).to have_content @item.title
    expect(page).to have_content @item.price
    expect(page).to have_content @item.description
    expect(page).to have_css "img[src*='#{@item.image}']"
  end

  scenario "they can add item to the cart" do
    click_on "Add to cart"

    expect(current_path).to eq item_path(@item)
    expect(page).to have_content "Successfully added #{@item.title} to your cart."
  end
end
