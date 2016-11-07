require "rails_helper"

describe "admin sees list of orders on dashboard" do
  scenario "they see all orders" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    item = create(:item)
    status = Status.create(name: "Ordered")
    address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: admin.id)
    order1 = Order.create(status_id: status.id, user_id: 1, address_id: address.id)
    order1.items << item
    order2 = Order.create(status_id: status.id, user_id: 1, address_id: address.id)
    order2.items << item

    visit admin_dashboard_path

    expect(page).to have_content "Order #{order1.id}"
    expect(page).to have_content "Order #{order2.id}"
    expect(page).to have_link "Order #{order1.id} placed #{order1.created_at.to_date}", href: order_path(order1)
    expect(page).to have_link "Order #{order2.id} placed #{order2.created_at.to_date}", href: order_path(order2)
  end

  scenario "admin sees list of statuses and count on dashboard" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    item = create(:item)
    status = Status.create(name: "Ordered")
    address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: admin.id)
    order1 = Order.create(status_id: status.id, user_id: admin.id, address_id: address.id)
    order1.items << item
    order2 = Order.create(status_id: status.id, user_id: admin.id, address_id: address.id)
    order2.items << item

    visit admin_dashboard_path

    expect(page).to have_content "#{status.name} 2"
  end

end
