class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @events = Event.all
  end

  def show
    # @event = Event.where(creator_id: event_params[:creator_id])
    @event = current_user.created_events.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      flash[:notice] = "Event successfully created"
      redirect_to @event
    else
      flash.now = "Error creating an event. Please try again"
      render :new, status: :unprocessable_entity
    end
  end


  private

  def event_params
    params.expect(event: [ :theme, :event_date, :venue, :description ])
    # params.require(:event).permit(:theme, :event_date, :venue, :description)
  end
end
