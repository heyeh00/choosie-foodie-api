class User < ApplicationRecord
  has_many :events
  has_many :restaurant_picks
  # has_many :restaurant_picks, through: :events
end
