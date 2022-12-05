class Api::V1::RestaurantPicksController < ApplicationController
  def create
    @restaurant_pick = RestaurantPick.create(
      user: current_user,
      event: @current_user.events,
      event_restaurant: @event_restaurant.event_id
    )

    render json: { restaurant_pick: @restaurant_pick }
  end
end
