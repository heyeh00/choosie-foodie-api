class Event < ApplicationRecord
  belongs_to :user
  has_many :restaurant_picks, dependent: :destroy
  has_many :event_restaurants, dependent: :destroy
end
