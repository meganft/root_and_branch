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
        user = User.new(name: "Bob", email: "cats@cats.com", password: "cats")
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
      user = User.create(name: "Bob", email: "cats@cats.com", password: "cats")
      expect(user).to respond_to(:orders)
    end
  end
end
