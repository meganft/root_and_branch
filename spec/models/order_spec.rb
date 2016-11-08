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

    it "belongs to address" do
      order = Order.create
      expect(order).to respond_to(:address)
    end

    it "has many items through order items" do
      order = Order.create
      expect(order).to respond_to(:items)
      expect(order).to respond_to(:order_items)
    end
  end

  describe ".order_total" do
    it "returns order total" do
      user = create(:user)
      status = create(:status)
      address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user.id)
      order = address.orders.create(user_id: user.id, status_id: status.id)
      order.items.create(title: "cat sweater", description: "lovely", price: 9.99, image: "cat.jpg", retired: false)
      order.items.create(title: "dog sweater", description: "charming", price: 34.43, image: "dog.jpg", retired: false)

      expect(order.order_total).to eq(44.42)
    end
  end

  describe ".count_by_status" do
    it "returns count by status" do
      user = create(:user)
      status = create(:status)
      status1 = Status.create(name:"Paid")
      address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user.id)

      order = Order.create(user_id: user.id, status_id: status.id, address_id: address.id)
      order1 = Order.create(user_id: user.id, status_id: status1.id, address_id: address.id)
      order2 = Order.create(user_id: user.id, status_id: status1.id, address_id: address.id)

      expect(Order.count_by_status.class).to eq(Hash)
      expect(Order.count_by_status.values).to eq([2,1])
    end
  end
end
