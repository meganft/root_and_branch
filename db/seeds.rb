# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create(name: "Grocery", slug: "grocery")
Category.create(name: "Accessories", slug: "accessories")
Category.create(name: "Jewelry", slug: "jewelry")
Category.create(name: "Home Goods", slug: "home-goods")

Item.create!(title: "Necklace", description: "Beautiful necklace!", price: 49.99, image: "carrots.jpeg", categories: Category.where(name: ["Accessories", "Jewelry"]))
Item.create!(title: "Hat", description: "Beautiful hat!", price: 49.99, image: "carrots.jpeg", categories: Category.where(name: "Accessories"))
Item.create!(title: "Almond Flour", description: "Yummy!", price: 49.99, image: "carrots.jpeg", categories: Category.where(name: "Grocery"))
Item.create!(title: "Throw Blanket", description: "Beautiful blanket!", price: 49.99, image: "carrots.jpeg", categories: Category.where(name: "Home Goods"))
Item.create!(title: "Bowl", description: "Beautiful bowl!", price: 49.99, image: "carrots.jpeg", categories: Category.where(name: ["Home Goods", "Grocery"]))
Item.create!(title: "Cat Sweater", description: "Beautiful cat sweater!", price: 49.99, image: "carrots.jpeg", categories: Category.where(name: ["Accessories", "Home Goods"]))
Item.create!(title: "Scarf", description: "Beautiful scarf!", price: 49.99, image: "carrots.jpeg", categories: Category.where(name: "Accessories"))
Item.create!(title: "Jam", description: "Yumm!", price: 49.99, image: "carrots.jpeg", categories: Category.where(name: "Grocery"))
