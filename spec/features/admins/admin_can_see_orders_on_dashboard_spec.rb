require "rails_helper"

describe "admin sees list of orders on dashboard" do
  scenario "they see all orders" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    item = create(:item)
    status = Status.create(name: "Ordered")
    order1 = Order.create(status_id: status.id, user_id: 1)
    order1.items << item
    order2 = Order.create(status_id: status.id, user_id: 1)
    order2.items << item

    visit admin_dashboard_path
    

    expect(page).to have_content "Order #{order1.id}"
    expect(page).to have_content "Order #{order2.id}"
  end
end
