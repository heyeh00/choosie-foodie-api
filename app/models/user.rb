class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :restaurant_picks, dependent: :destroy
  has_one_attached :avatar
  # has_many :restaurant_picks, through: :events
end
