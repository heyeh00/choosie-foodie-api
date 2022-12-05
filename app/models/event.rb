class Event < ApplicationRecord
  belongs_to :user
  has_many :restaurant_picks
  has_many :event_restaurants
end
