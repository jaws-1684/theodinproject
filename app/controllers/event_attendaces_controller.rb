class EventAttendacesController < ApplicationController
	def index
		@event_attendaces = current_user.attended_events
	end

	def create
		@event = Event.find(params[:event_id])

		@attendace = EventAttendance.new(attendee: current_user, attended_event: @event)
    
    if @attendace.save
      redirect_to @event, notice: "You are now attending this event!"
    else
      redirect_to @event, alert: "Something went wrong: #{attendance.errors.full_messages.join(', ')}"
    end
	end
end
