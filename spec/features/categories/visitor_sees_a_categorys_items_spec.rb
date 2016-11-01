require "rails_helper"

describe "visitor sees a category's items" do
  describe "they visit a category's page" do
    scenario "they see a single category with multiple items" do
      category = create(:category)
      item1 = category.items.create(title: "title1", description: "describe1", price: 7, image: "image path1")
      item2 = category.items.create(title: "title2", description: "describe2", price: 9, image: "image path2")

      visit category_path(category)
      expect(page).to have_content category.name
      expect(page).to have_content item1.title
      expect(page).to have_content item2.title
    end

    scenario "they do not see another category's items" do
      category1, category2 = create_list(:category, 2)
      item1 = category1.items.create(title: "title1", description: "describe1", price: 7, image: "image path1")
      item2 = category2.items.create(title: "title2", description: "describe2", price: 9, image: "image path2")

      visit category_path(category1)

      expect(page).to have_content category1.name
      expect(page).to have_content item1.title
      expect(page).to_not have_content item2.title
    end
  end
end
