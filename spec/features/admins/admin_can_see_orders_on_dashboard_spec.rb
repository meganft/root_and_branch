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


  scenario "admin sees list of statuses as filterable links and count on dashboard" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    item = create(:item)

    status1 = Status.create(name: "Ordered")
    status2 = Status.create(name: "Completed")
    address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: admin.id)
    order1 = Order.create(status_id: status1.id, user_id: admin.id, address_id: address.id)
    order1.items << item
    order2 = Order.create(status_id: status1.id, user_id: admin.id, address_id: address.id)
    order2.items << item

    visit admin_dashboard_path

    expect(page).to have_content "#{status1.name} 2"
    expect(page).to have_content "#{status2.name} 0"
    expect(page).to have_link "#{status1.name}", href:"/admin/dashboard?status=#{status1.name}"
  end

  scenario "admin sees orders of specific status when filtered" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    item = create(:item)
    status1 = Status.create(name: "Completed")
    status2 = Status.create(name: "Ordered")
    address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: admin.id)
    order3 = Order.create(status_id: status1.id, user_id: admin.id, address_id: address.id)
    order4 = Order.create(status_id: status2.id, user_id: admin.id, address_id: address.id)
    order3.items << item
    order4.items << item

    visit "/admin/dashboard?status=#{status1.name}"

    expect(page).to have_content "Order #{order3.id}"
    expect(page).to_not have_content "Order #{order4.id}"
  end

  scenario "admin sees flash message for unknown filter" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard?status=thing'

    expect(page).to have_content "Filter does not exist"
    expect(current_path).to eq admin_dashboard_path
  end

  scenario "admin can see other users' order show pages" do
    user = create(:user)
    status = Status.create(name: "Completed")
    address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user.id)
    order = user.orders.create(status_id: status.id, address_id: address.id)
    item = create(:item)
    order.items << item

    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit order_path(order)

    expect(page).to have_content(user.name.capitalize)
    expect(page).to have_content(order.id)
    expect(page).to have_content(item.title)
    expect(page).to have_content("Completed")
  end

end
