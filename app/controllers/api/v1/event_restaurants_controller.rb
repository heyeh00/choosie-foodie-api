class Api::V1::EventRestaurantsController < Api::V1::BaseController
  skip_before_action :verify_request

  def index
    set_event
    # @event.event_restaurants
    # @event_restaurants = []
    # @event.event_restaurants.each do |event_restaurant|
    #   @event_restaurants.push(event_restaurant)
    # end
    # render json: { event_restaurants: @event.event_restaurants }
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
