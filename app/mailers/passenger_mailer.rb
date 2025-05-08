class PassengerMailer < ApplicationMailer

	def confirmation_email(email)

			mail(to: email, subject: "Flight Details")
  end

end	
