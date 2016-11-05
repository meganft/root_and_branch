require 'rails_helper'

describe "user visits orders index" do
  scenario "user views past orders" do
    user = create(:user)
    user1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    status = create(:status)

    order1 = user.orders.create(status_id: status.id)
    order2 = user.orders.create(status_id: status.id)
    order3 = user1.orders.create(status_id: status.id)

    visit orders_path

    expect(page).to have_content(order1.id)
    expect(page).to have_content(order2.id)
    expect(page).to_not have_content("Order #: #{order3.id}")
  end

  scenario "user sees details of past orders" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    status = create(:status)
    order = user.orders.create(status_id: status.id)

    visit orders_path

    expect(page).to have_link("Order ##{order.id} placed #{order.created_at.to_date}", href: order_path(order))
  end

  scenario "user clicks on past order" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    status = Status.create(name: "Completed")
    order = user.orders.create(status_id: status.id)
    item1 = order.items.create(title: "cat sweater", description: "Beautiful cat sweater", price: 9.99, image: "sweater.jpg")
    item2 = order.items.create(title: "dog sweater", description: "Beautiful dog sweater", price: 9.99, image: "dogsweater.jpg")

    visit orders_path
    click_on("Order ##{order.id} placed #{order.created_at.to_date}")

    expect(current_path).to eq(order_path(order))
    expect(page).to have_link("cat sweater", href: item_path(item1))
    expect(page).to have_link("dog sweater", href: item_path(item2))
    expect(page).to have_content("Quantity: 1")
    expect(page).to have_content("Order Status: #{status.name}")
    expect(page).to have_content("Total: $19.98")
    expect(page).to have_content(order.created_at)
    expect(page).to have_content(status.created_at)
  end

  scenario "user sees each item once on page with multiple quantity" do
    user = User.create(name: "Bob", email: "cats@cats.cats", password: "cats")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    status = Status.create(name: "Completed")
    order = user.orders.create(status_id: status.id)
    item = order.items.create(title: "cat sweater", description: "Beautiful cat sweater", price: 9.99, image: "sweater.jpg")
    order.items << item

    visit order_path(order)

    within(".item_#{item.id}") do
      expect(page).to have_content "Quantity: 2"
    end
  end

end
