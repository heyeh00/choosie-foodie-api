# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'rest-client'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE



puts "destroying all"
Restaurant.destroy_all
Event.destroy_all
RestaurantPick.destroy_all

# cuisines = [
# "korean",

# "indian",

# "italian",

# "japanese",

# "spanish",

# "mexican",

# "thai",

# "veggies",

# "hotpot"
# ]

# 100.times do
#   restaurant = Restaurant.create(
#     name: Faker::Restaurant.name,
#     address: "#{Faker::Address.street_address} Shanghai",
#     cuisine: cuisines.sample(1)[0],
#     phone_number: Faker::PhoneNumber.cell_phone,
#     ave_price: (100..500).to_a.sample,
#     rating: (1..5).to_a.sample
#   )
#   puts restaurant.name
# end
puts "requesting restaurant"
restaurants_request = RestClient.get 'https://api.diningcity.asia/public/regions/shanghai/restaurants/search?region=shanghai&page=1&per_page=300&q=&lang=en', :verify_ssl => false

puts "parsing restaurants"
restaurants_array = JSON.parse(restaurants_request)
puts restaurants_array

puts "creating restaurants"
restaurants_array.each do |restaurant|
  name = restaurant["name"]
  address = restaurant["address"]
  cuisine = restaurant["cuisines"][0].nil? ? "" : restaurant["cuisines"][0]["name"]
  ave_price = restaurant["avg_price"].to_i
  image_url = restaurant["cover"],
  rating = restaurant["ratings_avg"].to_i

  Restaurant.create(
    name:,
    address:,
    cuisine:,
    ave_price:,
    image_url:,
    rating:
  )
end


puts "Restaurants created!"
