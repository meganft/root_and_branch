require 'rails_helper'

describe "user visits orders index" do
  scenario "user views past orders" do
    user = User.create(name: "Bob", email: "cats@cats.cats", password: "cats")
    user1 = User.create(name: "Megan", email: "megan@megan.megan", password: "megan")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    status = Status.create(name: "Completed")

    order1 = user.orders.create(status_id: status.id)
    order2 = user.orders.create(status_id: status.id)
    order3 = user1.orders.create(status_id: status.id)

    visit orders_path


    expect(page).to have_content(order1.id)
    expect(page).to have_content(order2.id)
    expect(page).to_not have_content(order3.id)
  end

  scenario "user sees details of past orders" do
    user = User.create(name: "Bob", email: "cats@cats.cats", password: "cats")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    status = Status.create(name: "Completed")
    order = user.orders.create(status_id: status.id)

    visit orders_path

    expect(page).to have_link("Order ##{order.id} placed #{order.created_at.to_date}", href: order_path(order))
  end

  scenario "user clicks on past order" do
    user = User.create(name: "Bob", email: "cats@cats.cats", password: "cats")
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
    expect(page).to have_content("cat sweater: 1")
    expect(page).to have_content("dog sweater: 1")
    expect(page).to have_content("Order Status: #{status.name}")
    expect(page).to have_content("Total: $19.98")
    expect(page).to have_content(order.created_at)
    expect(page).to have_content(status.created_at)
  end
end
