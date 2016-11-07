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
    expect(page).to have_link "Order #{order1.id} placed #{order1.created_at.to_date}", href: order_path(order1)
    expect(page).to have_link "Order #{order2.id} placed #{order2.created_at.to_date}", href: order_path(order2)
  end

  scenario "admin can see other users' order show pages" do
    user = create(:user)
    status = Status.create(name: "Completed")
    order = user.orders.create(status_id: status.id)
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

  scenario "admin sees list of statuses and count on dashboard" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    item = create(:item)
    status = Status.create(name: "Ordered")
    order1 = Order.create(status_id: status.id, user_id: admin.id)
    order1.items << item
    order2 = Order.create(status_id: status.id, user_id: admin.id)
    order2.items << item

    visit admin_dashboard_path

    expect(page).to have_content "#{status.name} 2"
  end

end
