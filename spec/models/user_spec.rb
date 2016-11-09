require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        user = User.new(email: "cats@cats.com", password: "cats")
        expect(user).to be_invalid
      end

      it "is invalid without a email" do
        user = User.new(name: "Bob", password: "cats")
        expect(user).to be_invalid
      end

      it "is invalid without a password" do
        user = User.new(name: "Bob", email: "cats@cats.com")
        expect(user).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with all attributes" do
        user = create(:user)
        expect(user).to be_valid
      end
    end

    context "uniqueness" do
      it "has a unique email" do
        User.create(name: "Bob", email: "cats@cats.com", password: "cats")
        user = User.new(name: "Steve", email: "cats@cats.com", password: "dogs")
        expect(user).to be_invalid
      end
    end
  end

  describe "relationships" do
    it "has many orders" do
      user = create(:user)
      expect(user).to respond_to(:orders)
    end

    it "has many addresses" do
      user = create(:user)
      expect(user).to respond_to(:addresses)
    end
  end

  describe ".has_order" do
    it "returns true if user has order" do
      user = create(:user)
      address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user.id)
      status = create(:status)
      order = user.orders.create(address_id: address.id, status_id: status.id)

      expect(user.has_order(order.id)).to eq(true)
    end

    it "returns false if user does not has order" do
      user = create(:user)
      user2 = create(:user)
      address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user2.id)
      status = create(:status)
      order = user2.orders.create(address_id: address.id, status_id: status.id)

      expect(user.has_order(order.id)).to eq(false)
    end
  end
end
