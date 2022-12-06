class Api::V1::RestaurantPicksController < Api::V1::BaseController
  def create
    @restaurant_pick = RestaurantPick.create(
      user: current_user,
      event: @current_user.events,
      event_restaurant: @event_restaurant.event_id
    )

    render json: { restaurant_pick: @restaurant_pick }
  end
end
