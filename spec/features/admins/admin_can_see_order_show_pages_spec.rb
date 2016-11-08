require 'rails_helper'

describe "admin sees user show page" do
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

  scenario "admin views an order show page" do
    user = create(:user)
    status = Status.create(name: "Completed")
    address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user.id)
    order = user.orders.create(status_id: status.id, address_id: address.id)
    item = create(:item)
    item2 = create(:item)
    order.items << item
    order.items << item2

    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit order_path(order)

    expect(page).to have_content(order.created_at.to_date)
    expect(page).to have_content(user.name.capitalize)
    expect(page).to have_content(address.street)
    expect(page).to have_link(item.title, href: item_path(item))
    expect(page).to have_link(item2.title, href: item_path(item2))
    expect(page).to have_content("Quantity: 1")
    expect(page).to have_content(item.price)
    expect(page).to have_content(item2.price)
    expect(page).to have_content("Subtotal: $#{item.price}0")
    expect(page).to have_content("Total: $#{item.price + item2.price}0")
    expect(page).to have_content(status.name)
  end
end
