class UsersController < ApplicationController
	def show
		@attended_events =	current_user.attended_events
	end
end