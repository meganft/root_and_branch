require 'rails_helper'

describe "an authenticated user can only see permitted information" do
  scenario "an authenticated user cannot view another user's private data" do
    user1 = create(:user)
    status = create(:status)
    address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user1.id)
    order = user1.orders.create(status_id: status.id, address_id: address.id)
    item = create(:item)
    order.items << item

    user2 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit dashboard_path

    expect(page).to have_content(user2.name)

    click_on "See your past orders"

    expect(page).to_not have_content(order.id)
    expect(page).to_not have_content(item.title)

    visit user_path(user1)

    expect(page).to_not have_content(user1.name)
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "an authenticated user cannot view another user's order" do
    user1 = create(:user)
    status = create(:status)
    address = Address.create(street: "2447 Julian Street", city: "Denver", state: "CO", zip: 80211, user_id: user1.id)
    order = user1.orders.create(status_id: status.id, address_id: address.id)
    item = create(:item)
    order.items << item

    user2 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit order_path(order)

    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  scenario "an authenticated user cannot view admin screens or user admin functionality" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
