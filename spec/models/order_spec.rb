require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "relationships" do
    it "belongs to user" do
      order = Order.create
      expect(order).to respond_to(:user)
    end

    it "belongs to status" do
      order = Order.create
      expect(order).to respond_to(:status)
    end

    it "has many items through order items" do
      order = Order.create
      expect(order).to respond_to(:items)
      expect(order).to respond_to(:order_items)
    end
  end
end
