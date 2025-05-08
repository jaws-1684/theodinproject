class ApplicationMailer < ActionMailer::Base
  default from: "flights@booking.com"
  layout "mailer"
end
