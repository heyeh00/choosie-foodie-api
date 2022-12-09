class EventRestaurant < ApplicationRecord
  belongs_to :event
  belongs_to :restaurant
  has_many :restaurant_picks, dependent: :destroy
end
