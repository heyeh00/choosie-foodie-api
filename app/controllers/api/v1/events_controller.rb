class Api::V1::EventsController < Api::V1::BaseController
  skip_before_action :verify_request

  def index
    @events = Event.all.select { |event| event.user == current_user }
  end

  def generate_cuisine_list
    # randomly generate list of 9 unique cuisines for users to filter
    restaurants = Restaurant.all
    cuisines = restaurants.map { |i| i[:cuisine] }.uniq.sample(9)
    render json: { cuisines: }
  end

  def create
    # cuisine_categories = generate_cuisine_list
    # render json: { cuisine_categories: }
    set_user
    @event = Event.new(event_params)
    puts "EVENT CREATE #{@event}"
    if @event.save
      @event_restaurants = generate_event_restaurants
      render json: { event: @event }
    else
      render json: { status: 'fail', msg: 'failed to create new event' }
    end
  end

  def show
    @event = Event.find(params[:id])
    render json: { event: @event }
  end

  private

  def set_user
    @user = @current_user
  end

  def event_params
    params.require(:event).permit(:user_id, :event_name, :datetime, :price_min, :price_max, :cuisines)
  end

  def filter_restaurants
    # This filters all restaurants by user selected cuisine types
    cuisines = params[:cuisines]
    if cuisines.empty?
      restaurants = Restaurant.all
    else
      restaurants = []
      cuisines.each do |cuisine|
        Restaurant.all.each do |restaurant|
          restaurants.push(restaurant) if restaurant.cuisine == cuisine
        end
      end
    end
    restaurants
  end

  def generate_event_restaurants
    # Generate 20 event_restaurants for users to choose from
    filtered = filter_restaurants
    restaurants = filtered.sample(20)
    restaurants.each do |restaurant|
      EventRestaurant.create(
        event: @event,
        restaurant:
      )
    end
  end
end
