class User < ApplicationRecord
  has_many :swipes
  has_many :events
  has_many :swipes, through: :events
end
