# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create(name: "Grocery")
Category.create(name: "Accessories")
Category.create(name: "Jewelry")
Category.create(name: "Home Goods")

Item.create!(title: "Necklace", description: "Beautiful necklace!", price: 49.99, image: "https://images.unsplash.com/photo-1452724222179-950de6f4a3ce?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&s=180ed898e0b885ea3413e671d1530517", categories: Category.where(name: ["Accessories", "Jewelry"]))
Item.create!(title: "Hat", description: "Beautiful hat!", price: 49.99, image: "https://images.unsplash.com/photo-1452724222179-950de6f4a3ce?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&s=180ed898e0b885ea3413e671d1530517", categories: Category.where(name: "Accessories"))
Item.create!(title: "Almond Flour", description: "Yummy!", price: 49.99, image: "https://images.unsplash.com/photo-1452724222179-950de6f4a3ce?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&s=180ed898e0b885ea3413e671d1530517", categories: Category.where(name: "Grocery"))
Item.create!(title: "Throw Blanket", description: "Beautiful blanket!", price: 49.99, image: "https://images.unsplash.com/photo-1452724222179-950de6f4a3ce?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&s=180ed898e0b885ea3413e671d1530517", categories: Category.where(name: "Home Goods"))
Item.create!(title: "Bowl", description: "Beautiful bowl!", price: 49.99, image: "https://images.unsplash.com/photo-1452724222179-950de6f4a3ce?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&s=180ed898e0b885ea3413e671d1530517", categories: Category.where(name: ["Home Goods", "Grocery"]))
Item.create!(title: "Cat Sweater", description: "Beautiful cat sweater!", price: 49.99, image: "https://images.unsplash.com/photo-1452724222179-950de6f4a3ce?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&s=180ed898e0b885ea3413e671d1530517", categories: Category.where(name: ["Accessories", "Home Goods"]))
Item.create!(title: "Scarf", description: "Beautiful scarf!", price: 49.99, image: "https://images.unsplash.com/photo-1452724222179-950de6f4a3ce?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&s=180ed898e0b885ea3413e671d1530517", categories: Category.where(name: "Accessories"))
Item.create!(title: "Jam", description: "Yumm!", price: 49.99, image: "https://images.unsplash.com/photo-1452724222179-950de6f4a3ce?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&s=180ed898e0b885ea3413e671d1530517", categories: Category.where(name: "Grocery"))
