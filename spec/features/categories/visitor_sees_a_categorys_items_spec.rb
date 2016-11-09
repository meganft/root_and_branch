require "rails_helper"

describe "visitor sees a category's items" do
  before :each do
    @category = create(:item_on_category)
    @item1, @item2 = @category.items
  end

  scenario "they see a single category with multiple items" do
    visit category_path(@category)

    expect(page).to have_content @category.name
    expect(page).to have_content @item1.title
    expect(page).to have_content "$#{@item1.price}0"
    expect(page).to have_content @item2.title
    expect(page).to have_content "$#{@item2.price}0"
  end

  scenario "they do not see another category's items" do
    item3 = create(:item)

    visit category_path(@category)

    expect(page).to have_content @category.name
    expect(page).to have_content @item1.title
    expect(page).to_not have_content item3.title
  end
end
