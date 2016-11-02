require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "relationships" do
    it "belongs to user" do
      order = Order.create
      expect(order).to respond_to(:user)
    end
  end
end
