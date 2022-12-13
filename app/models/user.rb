class User < ApplicationRecord
  has_many :events
  has_many :restaurant_picks
  has_one_attached :avatar
  # has_many :restaurant_picks, through: :events
end
