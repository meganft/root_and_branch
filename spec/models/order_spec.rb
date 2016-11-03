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

  describe ".order_total" do
    it "returns order total" do
      user = User.create(name: "Bob", email: "cats@cats.cats", password: "cats")
      status = Status.create(name: "Completed")
      order = Order.create(user_id: user.id, status_id: status.id)
      order.items.create(title: "cat sweater", description: "lovely", price: 9.99, image: "cat.jpg", retired: false)
      order.items.create(title: "dog sweater", description: "charming", price: 34.43, image: "dog.jpg", retired: false)

      expect(order.order_total).to eq(44.42)
    end
  end
end
