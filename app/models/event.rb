class Event < ApplicationRecord
  belongs_to :user
  has_many :swipes
  has_many :event_restaurants
end
