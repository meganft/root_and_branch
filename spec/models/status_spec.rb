require 'rails_helper'

RSpec.describe Status, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        status = Status.new()
        expect(status).to be_invalid
      end
    end
    context "valid attributes" do
      it "is valid with all attributes" do
        status = Status.new(name: "Completed")
        expect(status).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many orders" do
      status = Status.create(name: "Completed")
      expect(status).to respond_to(:orders)
    end
  end
end
