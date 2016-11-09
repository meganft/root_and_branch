require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        category = Category.new()
        expect(category).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        category = create(:category)
        expect(category).to be_valid
      end
    end

    context "uniqueness" do
      it "has a unique name" do
        Category.create(name: "Cats")
        category = Category.new(name: "Cats")
        expect(category).to be_invalid
      end
    end
  end

  describe "relationships" do
    it "has many items through item categories" do
      category = create(:category)
      expect(category).to respond_to(:items)
      expect(category).to respond_to(:item_categories)
    end
  end

  describe ".set_slug" do
    it "creates a slug for the category" do
      category = Category.create(name: "Cat Sweaters")

      expect(category.set_slug).to eq("cat-sweaters")
    end
  end
end
