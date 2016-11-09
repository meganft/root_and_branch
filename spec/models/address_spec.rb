require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a street" do
        user = create(:user)
        address = Address.new(city: "Denver", state: "CO", zip: 80211, user_id: user.id)
        expect(address).to be_invalid
      end

      it "is invalid without a city" do
        user = create(:user)
        address = Address.new(street: "2447 Julian Street", state: "CO", zip: 80211, user_id: user.id)
        expect(address).to be_invalid
      end

      it "is invalid without a state" do
        user = create(:user)
        address = Address.new(street: "2447 Julian Street", city: "Denver", zip: 80211, user_id: user.id)
        expect(address).to be_invalid
      end

      it "is invalid without a zip" do
        user = create(:user)
        address = Address.new(street: "2447 Julian Street", city: "Denver", state: "CO", user_id: user.id)
        expect(address).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with all attributes" do
        user = create(:user)
        address = Address.new(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user.id)
        expect(address).to be_valid
        end
    end
  end

  describe "relationships" do
    it "belongs to a user" do
      user = create(:user)
      address = Address.new(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user.id)
      expect(address).to respond_to(:user)
    end

    it "has many orders" do
      user = create(:user)
      address = Address.new(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user.id)
      expect(address).to respond_to(:orders)
    end
  end
end
