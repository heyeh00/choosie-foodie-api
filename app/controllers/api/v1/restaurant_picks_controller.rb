class Api::V1::RestaurantPicksController < ApplicationController
  def show
    @restaurant_pick = RestaurantPick.find(params[:id])
    render json: { restaurant_pick: @restaurant_pick}
  end
end
