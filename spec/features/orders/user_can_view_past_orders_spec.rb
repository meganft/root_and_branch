require 'rails_helper'

describe "user visits orders index" do
  scenario "user views past orders" do
    user = User.create(name: "Bob", email: "cats@cats.cats", password: "cats")
    user1 = User.create(name: "Megan", email: "megan@megan.megan", password: "megan")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    order1 = user.orders.create
    order2 = user.orders.create
    order3 = user1.orders.create


    visit orders_path

    expect(page).to have_content(order1.id)
    expect(page).to have_content(order2.id)
    expect(page).to_not have_content(order3.id)
  end
end
