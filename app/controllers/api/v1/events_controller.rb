class Api::V1::EventsController < Api::V1::BaseController
  skip_before_action :verify_request

  def index
    # Allow profile page to get every event and the event's restaurant_result for a user
    @user = User.find(params[:id])
    @events = []
    @user.restaurant_picks.each do |pick|
      @event_info = {}
      @event = pick.event
      @event_info[:event] = @event
      @event_info[:restaurant] = result_restaurant
      @event_info[:attendees] = event_attendees
      @events.push(@event_info)
    end
    render json: { user_events: @events }
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
    if @event.save
      @event_restaurants = generate_event_restaurants
      render json: { event: @event }
    else
      render json: { status: 'fail', msg: 'failed to create new event' }
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    render json: { event: @event }
  end

  def show
    set_event
    render json: { event: @event }
  end

  def event_result
    # GO TO views/api/v1/events/event_result.json.jbuilder
    # Get event info
    set_event
    # Get the most voted restaurant
    result_restaurant
    # Get all of the people attending
    event_attendees
  end

  private

  def result_restaurant
    # set_event
    all_picks = @event.restaurant_picks
    all_picks_ids = []
    all_picks.each do |pick|
      all_picks_ids.push(pick.event_restaurant_id)
    end
    result_id = all_picks_ids.max_by { |i| all_picks_ids.count(i) }
    event_restaurant = EventRestaurant.find(result_id)
    @restaurant = event_restaurant.restaurant
  end

  def event_attendees
    @attendees = []
    attendee_picks = @event.restaurant_picks
    # attendee_picks.each do |pick|
    #   attendee = pick.user
    #   @attendees.push(attendee)
    # end
    attendee_picks.each do |pick|
      user = pick.user
      user[:image_url] = pick.user.avatar.url
      @attendees.push(user)
    end
    @attendees = @attendees.uniq
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_user
    @user = @current_user
  end

  def event_params
    params.require(:event).permit(:user_id, :event_name, :datetime, :price_min, :price_max, :cuisines, :closed)
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
