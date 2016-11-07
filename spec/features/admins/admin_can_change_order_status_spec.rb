require 'rails_helper'

describe "admin can change order status" do
  before :each do
    @admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    @item = create(:item)
    @status1 = Status.create(name: "Ordered")
    @status2 = Status.create(name: "Paid")
    @status3 = Status.create(name: "Cancelled")
    @status4 = Status.create(name: "Completed")
  end

  scenario "admin can change order status to Paid from dashboard" do
    order1 = Order.create(status_id: @status1.id, user_id: @admin.id)
    order1.items << @item

    visit admin_dashboard_path
    expect(page).to have_content "Paid 0"
    within(".order_#{order1.id}") do
      click_on "Paid"
    end

    expect(page).to have_content "Paid 1"
    # expect(order1.status.name).to eq(@status2.name)
  end

  scenario "admin can change order status to Cancelled from dashboard" do
    order2 = Order.create(status_id: @status1.id, user_id: @admin.id)
    order2.items << @item
    visit admin_dashboard_path
    expect(page).to have_content "Cancelled 0"

    within(".order_#{order2.id}") do
      click_on "Cancel"
    end

    expect(page).to have_content "Cancelled 1"
    # expect(order2.status.name).to eq(@status3.name)
  end

  scenario "admin can change order status to Completed from dashboard" do
    order3 = Order.create(status_id: @status2.id, user_id: @admin.id)
    order3.items << @item
    visit admin_dashboard_path
    expect(page).to have_content "Completed 0"

    within(".order_#{order3.id}") do
      click_on "Completed"
    end

    expect(page).to have_content "Completed 1"
    # expect(order2.status.name).to eq(@status3.name)
  end
end
