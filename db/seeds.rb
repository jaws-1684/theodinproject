# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

airport_objects = {}

airports = [
  "CDG", "LHR", "AMS", "FRA", "MAD", "BCN", "IST", "MUC", "FCO", "ZRH",
  "CPH", "ARN", "BRU", "VIE", "DUB", "OSL", "WAW", "PRG", "LIS", "ATH",
  "HEL", "MXP", "LED", "MAN", "DUS", "SVO", "KRK", "GVA", "LYS", "BUD"
]

airports.each do |code|
	airport = Airport.find_or_create_by!(airport_code: code)
	airport_objects[code] = airport
end


50.times do
  departure_code = airports.sample
  arrival_code = (airports - [departure_code]).sample 

  departure_date = Faker::Time.forward(days: 30, period: :day) 
  flight_duration = rand(90..240) 

  Flight.create!(
    departure_airport: airport_objects[departure_code],
    arrival_airport: airport_objects[arrival_code],
    start_datetime: departure_date,
    flight_duration: flight_duration
  )
end