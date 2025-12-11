class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", inverse_of: "created_events"
  has_many :event_attendings, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendings, source: :event_attendee

  def self.past
    Event.where("event_date < :today", { today: Time.now })
  end

  def self.pending
    Event.where("event_date >= :today", { today: Time.now })
  end
end
