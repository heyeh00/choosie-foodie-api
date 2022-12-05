class Api::V1::EventsController < ApplicationController

  def index
    @events = Event.all.select { |event| event.user == current_user }
  end

  def create
    @event = Event.new(event_params)
    @event_restaurants = generate_event_restaurants
    if @event.save
      render json: { event: @event }
      render json: { event_restaurants: @event_restaurants }
    else
      render json: { status: 'fail', msg: 'failed to create new event' }
    end
  end

  def show
    @event = Event.find(params[:id])
    render json: { event: @event }
  end

  private

  def event_params
    params.require(:event).permit(:event_name, :datetime, :price_min, :price_max, :cuisine)
  end

  def filter_restaurants
    cuisines = params(:cuisine)
    restaurants = []
    cuisines.each do |cuisine|
      Restaurant.all.each do |restaurant|
        restaurants.push(restaurant) if restaurant.cuisine == cuisine
      end
    end
  end

  def generate_event_restaurants
    # EventRestaurant.create(event: @event, restaurant: Restaurant.all.sample(20))
    restaurants = filter_restaurants
    EventRestaurant.create(
      event: @event,
      restaurant: restaurants.sample(20)
    )
  end
end
