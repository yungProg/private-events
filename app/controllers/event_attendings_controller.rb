class EventAttendingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])

    unless @event.attendees.include?(current_user)
      @event.attendees << current_user
      flash[:notice] = "You have been added to the guests list"
      redirect_to event_path(params[:event_id])
    else
      flash.now[:error] = "Error while adding you to guest"
    end
  end
end
