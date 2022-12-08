class Api::V1::RestaurantsController < Api::V1::BaseController
  skip_before_action :verify_request

  def show
  end

  def index
    set_event
    puts "#{EVENT EVENT EVENT} @event"
    @restaurants = []
    @event.restaurants.each do |restaurant|
      @restaurants.push(restaurant.restaurant)
    end
    render json: { restaurants: @restaurants }
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
