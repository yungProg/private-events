class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    # @past_events = Event.past
    # @pending_events = Event.pending
    # Replaced class methods above with :scope in model

    @past_events = Event.past_events
    @pending_events = Event.pending_events
  end

  def show
    # @event = Event.where(creator_id: event_params[:creator_id])
    @event = Event.find(params[:id])
    @attendings = EventAttending.where("attended_event_id = ? AND rsvp = ?", @event.id, 1)
  end

  def new
    @event = Event.new(status: :privatized)
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      flash[:notice] = "Event successfully created"
      redirect_to @event
    else
      flash.now[:error] = "Error creating an event. Please try again"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      flash[:notice] = "Event successfully updated"
      redirect_to @event
    else
      flash.now[:error] = "Couldn't update event. Try again"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])

    @event.destroy
    redirect_to root_path
  end


  private

  def event_params
    params.expect(event: [ :theme, :event_date, :venue, :description, :status ])
    # params.require(:event).permit(:theme, :event_date, :venue, :description)
  end
end
