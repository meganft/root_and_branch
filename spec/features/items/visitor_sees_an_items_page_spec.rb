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


end
