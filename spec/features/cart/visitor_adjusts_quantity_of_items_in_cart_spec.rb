require "rails_helper"

describe "visitor adjusts quantity of item in cart" do
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

  scenario "they can decrease quantity of items" do
    visit category_path(@category)
    within(".item_#{@item1.id}") do
      click_on "Add to cart"
    end

    within(".item_#{@item1.id}") do
      expect(page).to have_content("Quantity: 2")
    end

    within(".item_#{@item1.id}") do
      click_on "-"
    end

    within(".item_#{@item1.id}") do
      expect(page).to have_content("Quantity: 1")
    end
  end

  scenario "they can increase quantity of items" do
    visit cart_path

    within(".item_#{@item1.id}") do
      click_on "+"
    end

    within(".item_#{@item1.id}") do
      expect(page).to have_content("Quantity: 2")
    end
  end

  scenario "they see the subtotal change with quantity" do
    visit cart_path

    within(".item_#{@item1.id}") do
      expect(page).to have_content "Subtotal: $#{@item1.price}0"
    end
    click_on "+"

    subtotal = @item1.price * 2

    within(".item_#{@item1.id}") do
      expect(page).to have_content "Subtotal: $#{subtotal}0"
    end
  end

end
