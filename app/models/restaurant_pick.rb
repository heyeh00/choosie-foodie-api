class RestaurantPick < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :event_restaurant
end
