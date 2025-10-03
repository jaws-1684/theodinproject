class PassengerMailer < ApplicationMailer

	def confirmation_email(email, booking)
			@email = email
			@booking = booking
			@passenger = Passenger.find_by(email: email)
			mail(to: email, subject: "Flight Details")
  end

end	
