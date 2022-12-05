# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


puts "destroying all restaurants"

100.times do
  restaurant = Restaurant.create(
    name: Faker::Restaurant.name,
    address: "#{Faker::Address.street_address} Shanghai",
    cuisine: Faker::Restaurant.type,
    phone_number: Faker::PhoneNumber.cell_phone,
    ave_price: [100..500].sample,
    rating: [1..5].sample
  )
  puts restaurant.name
end

puts "Restaurants created!"
