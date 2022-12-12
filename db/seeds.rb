# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


puts "destroying all"
Restaurant.destroy_all
Event.destroy_all
RestaurantPick.destroy_all

cuisines = [
"Korean",

"Indian",

"Italian",

"Japanese",

"Spanish",

"Mexican",

"Thai",

"Veggies",

"Hotpot"
]

100.times do
  restaurant = Restaurant.create(
    name: Faker::Restaurant.name,
    address: "#{Faker::Address.street_address} Shanghai",
    cuisine: cuisines.sample(1)[0],
    phone_number: Faker::PhoneNumber.cell_phone,
    ave_price: (100..500).to_a.sample,
    rating: (1..5).to_a.sample
  )
  puts restaurant.name
end

puts "Restaurants created!"
