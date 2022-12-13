class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :verify_request

  def show
    @user = User.find(params[:id])
    # Get all attended events and corresponding restaurants
    user_attended_events

    render json: { user_events: @events }
  end

  def attach_avatar
    @user = User.find(params[:id])
    @user.avatar.attach(params[:avatar])
    render json: { user: @user, avatar: @user.avatar.url }
  end

  def update
    @user = User.find(params[:id])
    if @user.avatar.url
      @user.update(user_params)
    else
      @user.update(user_params)
      attach_avatar
    end
    render json: { user: @user, avatar: @user.avatar.url }
  end

  private

  def user_attended_events
    restaurant_picks = @user.restaurant_picks
    @events = []
    restaurant_picks.each do |restaurant_pick|
      @events.push(restaurant_pick.event)
    end
  end

  def user_params
    params.require(:user).permit(:name, :open_id, :image_url, :avatar)
  end
end
