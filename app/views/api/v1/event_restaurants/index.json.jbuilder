hash = { selected: false }
json.events do
  json.array! @event.event_restaurants do |event_restaurant|
    json.extract! event_restaurant, :id
    json.restaurant event_restaurant.restaurant
    json.merge! hash
  end
end
