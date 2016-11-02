require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        item = Item.new(description: "fuzzy", price: 5.75, image: "cat.jpg")
        expect(item).to be_invalid
      end

      it "is invalid without a description" do
        item = Item.new(title: "cat", price: 5.75, image: "cat.jpg")
        expect(item).to be_invalid
      end

      it "is invalid without a price" do
        item = Item.new(title: "cat", description: "fuzzy", image: "cat.jpg")
        expect(item).to be_invalid
      end

      it "is invalid without an image" do
        item = Item.new(title: "cat", description: "fuzzy", price: 5.75)
        expect(item).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with all attributes" do
        item = Item.new(title: "cat", description: "fuzzy", price: 5.75, image: "cat.jpg")
        expect(item).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many categories through item categories" do
      item = create(:item)
      expect(item).to respond_to(:categories)
      expect(item).to respond_to(:item_categories)
    end

    it "has many orders through order items" do
      item = create(:item)
      expect(item).to respond_to(:orders)
      expect(item).to respond_to(:order_items)
    end
  end
end
