class Api::V1::EventsController < ApplicationController

  def index
    @events = Event.all.select { |event| event.user == current_user }
  end

  def create
    @event = Event.new(event_params)
    if @event.save
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

  def event_params
    params.require(:event).permit(:event_name, :datetime, :price_min, :price_max, :cuisine)
  end
end
