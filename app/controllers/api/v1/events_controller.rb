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
    set_event
    render json: { event: @event }
  end

  def event_result
    set_event
    all_picks = @event.restaurant_picks
    all_picks_ids = []
    all_picks.each do |pick|
      all_picks_ids.push(pick.event_restaurant_id)
    end
    result_id = all_picks_ids.max_by { |i| all_picks_ids.count(i) }
    event_restaurant = EventRestaurant.find(result_id)
    restaurant = event_restaurant.restaurant
    render json: { restaurant: }
  end

  def event_attendees
    set_event
    attendees = []
    attendee_picks = @event.restaurant_picks
    attendee_picks.each do |pick|
      attendee = pick.user
      attendees.push(attendee)
    end
    render json: { attendees: }
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_user
    @user = @current_user
  end

  def event_params
    params.require(:event).permit(:user_id, :event_name, :datetime, :price_min, :price_max, :cuisines)
  end

  def filter_restaurants
    # This filters all restaurants by user selected cuisine types
    cuisines = params[:cuisines]
    if cuisines.nil?
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
