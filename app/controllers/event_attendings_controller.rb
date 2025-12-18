class EventAttendingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @event_attending = EventAttending.new
  end

  def create
    @event = Event.find(params[:event_id])
    @invitee = User.find(params[:event_attending][:invitee_id])

    unless @event.attendees.include?(@invitee)
      @event.event_attendings.create event_attendee: @invitee
      flash[:notice] = "#{@invitee.email} has been invited"
      redirect_to event_path(params[:event_id])
    else
      flash[:error] = "#{@invitee.email} has already been invited"
      redirect_to event_path(params[:event_id])
    end
  end

  def update
    event_attending = EventAttending.find_by(event_attendee_id: current_user.id, attended_event_id: params[:event_id])

    if params[:response] == "0"
      event_attending.rejected!
    elsif params[:response] =="1"
      event_attending.accepted!
    end

    flash[:notice] = "You have #{event_attending.rsvp} the invitation"
    redirect_back fallback_location: root_path
  end
end
