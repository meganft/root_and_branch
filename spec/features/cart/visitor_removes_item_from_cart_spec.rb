require "rails_helper"

describe "visitor removes item from cart" do
  before :each do
    @category = create(:item_on_category)
    @item1, @item2 = @category.items
    visit category_path(@category)
    within(".item_#{@item1.id}") do
      click_on "Add to cart"
    end
  end

  scenario "they select an item to delete" do
    visit cart_path
    save_and_open_page
    within(".item_#{@item1.id}") do
      click_on "Remove"
    end

    expect(page).to_not have_content @item1.description
    expect(page).to have_content "Successfully removed #{@item1.title} from cart."
    expect(page).to have_link item_path(@item)
    expect(current_path).to eq cart_path
  end
end
