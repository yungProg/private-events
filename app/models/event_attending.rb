class EventAttending < ApplicationRecord
  belongs_to :event_attendee, class_name: "User"
  belongs_to :attended_event, class_name: "Event"

  enum :rsvp, { rejected: 0, accepted: 1, pending: 2 }
end
