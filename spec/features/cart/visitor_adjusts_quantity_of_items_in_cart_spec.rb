require "rails_helper"

describe "visitor can adjust quantity of item in cart" do
  before :each do
    @category = create(:item_on_category)
    @item1, @item2 = @category.items
    visit category_path(@category)
    within(".item_#{@item1.id}") do
      click_on "Add to cart"
    end
  end

  scenario "they can see the current quantity in cart" do
    visit cart_path

    within(".item_#{@item1.id}") do
      expect(page).to have_content("Quantity: 1")
    end
  end

  scenario "they can increase quantity of items" do

  end

  scenario "they can decrease quantity of items" do

  end
end
