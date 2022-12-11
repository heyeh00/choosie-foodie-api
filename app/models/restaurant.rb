class Restaurant < ApplicationRecord
  has_many :event_restaurants, dependent: :destroy
end
