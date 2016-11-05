require 'rails_helper'

describe "Admin creates a new category" do
  scenario "When admin creates a category a slug is created for that category" do
    category = create(:category)

    expect(category.slug).to eq("cat-sweaters")
  end
end
