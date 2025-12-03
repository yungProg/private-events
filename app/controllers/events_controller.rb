class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @events = Event.all
  end

  def show
    # @event = Event.where(creator_id: event_params[:creator_id])
    @event = current_user.created_events
  end


  private

  def event_params
    params.expect(event: [ :theme, :event_date, :venue, :creator_id ])
  end
end
