# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Seed data with realistic European flight connections and city names
# Updated airport data with all required airports
airport_data = {
  "CDG" => { city: "Paris" },
  "LHR" => { city: "London" },
  "AMS" => { city: "Amsterdam" },
  "FRA" => { city: "Frankfurt" },
  "MAD" => { city: "Madrid" },
  "BCN" => { city: "Barcelona" },
  "IST" => { city: "Istanbul" },
  "MUC" => { city: "Munich" },
  "FCO" => { city: "Rome" },
  "ZRH" => { city: "Zurich" },
  "CPH" => { city: "Copenhagen" },
  "ARN" => { city: "Stockholm" },
  "BRU" => { city: "Brussels" },
  "VIE" => { city: "Vienna" },
  "DUB" => { city: "Dublin" },
  "OSL" => { city: "Oslo" },
  "WAW" => { city: "Warsaw" },
  "PRG" => { city: "Prague" },
  "LIS" => { city: "Lisbon" },
  "ATH" => { city: "Athens" },
  "HEL" => { city: "Helsinki" },
  "MXP" => { city: "Milan" },
  "LED" => { city: "St. Petersburg" },
  "MAN" => { city: "Manchester" },
  "DUS" => { city: "Düsseldorf" },
  "SVO" => { city: "Moscow" },
  "KRK" => { city: "Krakow" },
  "GVA" => { city: "Geneva" },
  "LYS" => { city: "Lyon" },
  "BUD" => { city: "Budapest" },
  "EDI" => { city: "Edinburgh" } # Added missing airport
}

# Create airports with city information
airport_objects = {}
airport_data.each do |code, info|
  airport = Airport.find_or_create_by!(
    airport_code: code,
    city: info[:city]
  )
  airport_objects[code] = airport
end

# Updated flight connections with valid airport codes
# Expanded flight connections for all airports
flight_connections = {
  "CDG" => { # Paris
    destinations: [ "LHR", "AMS", "FRA", "MAD", "BCN", "IST", "MUC", "FCO", "ZRH", "CPH", "BRU", "VIE", "DUB", "WAW", "LIS", "ATH", "HEL", "MXP", "DUS", "SVO", "GVA", "BUD" ],
    durations: [ 90, 90, 120, 150, 135, 210, 110, 110, 90, 120, 60, 110, 90, 150, 150, 210, 210, 90, 90, 210, 60, 120 ]
  },
  "LHR" => { # London
    destinations: [ "CDG", "AMS", "FRA", "MAD", "BCN", "IST", "DUB", "EDI", "FCO", "ZRH", "CPH", "ARN", "BRU", "VIE", "OSL", "WAW", "PRG", "LIS", "ATH", "HEL", "MXP", "DUS" ],
    durations: [ 90, 90, 110, 150, 135, 210, 60, 60, 110, 90, 105, 120, 60, 110, 105, 150, 110, 150, 210, 180, 90, 90 ]
  },
  "AMS" => { # Amsterdam
    destinations: [ "CDG", "LHR", "FRA", "MAD", "BCN", "IST", "MUC", "FCO", "ZRH", "CPH", "BRU", "VIE", "DUB", "WAW", "PRG", "LIS", "ATH", "HEL", "MXP", "DUS", "MAN" ],
    durations: [ 90, 90, 80, 150, 145, 210, 90, 120, 85, 90, 40, 105, 100, 120, 90, 180, 195, 150, 100, 60, 75 ]
  },
  "FRA" => { # Frankfurt
    destinations: [ "CDG", "LHR", "AMS", "MAD", "BCN", "IST", "MUC", "FCO", "ZRH", "CPH", "BRU", "VIE", "WAW", "PRG", "LIS", "ATH", "HEL", "MXP", "DUS", "SVO", "GVA", "BUD" ],
    durations: [ 120, 110, 80, 150, 140, 180, 60, 105, 60, 90, 70, 80, 90, 60, 180, 165, 150, 90, 45, 180, 80, 90 ]
  },
  "MAD" => { # Madrid
    destinations: [ "CDG", "LHR", "AMS", "FRA", "BCN", "IST", "FCO", "ZRH", "BRU", "VIE", "LIS", "ATH", "MXP", "DUS", "PRG" ],
    durations: [ 150, 150, 150, 150, 75, 240, 140, 140, 150, 165, 80, 210, 135, 170, 180 ]
  },
  "BCN" => { # Barcelona
    destinations: [ "CDG", "LHR", "AMS", "FRA", "MAD", "IST", "MUC", "FCO", "ZRH", "BRU", "VIE", "LIS", "ATH", "MXP", "DUS" ],
    durations: [ 135, 135, 145, 140, 75, 210, 120, 110, 120, 135, 150, 120, 180, 105, 150 ]
  },
  "IST" => { # Istanbul
    destinations: [ "CDG", "LHR", "AMS", "FRA", "MAD", "BCN", "MUC", "FCO", "ZRH", "CPH", "BRU", "VIE", "ATH", "SVO", "BUD" ],
    durations: [ 210, 210, 210, 180, 240, 210, 165, 150, 180, 180, 195, 120, 90, 150, 120 ]
  },
  "MUC" => { # Munich
    destinations: [ "CDG", "LHR", "AMS", "FRA", "BCN", "IST", "FCO", "ZRH", "CPH", "BRU", "VIE", "WAW", "PRG", "ATH", "MXP", "DUS", "BUD" ],
    durations: [ 110, 120, 90, 60, 120, 165, 90, 55, 90, 90, 60, 90, 60, 150, 75, 70, 80 ]
  },
  "FCO" => { # Rome
    destinations: [ "CDG", "LHR", "AMS", "FRA", "MAD", "BCN", "IST", "MUC", "ZRH", "BRU", "VIE", "ATH", "MXP", "DUS" ],
    durations: [ 110, 150, 120, 105, 140, 110, 150, 90, 95, 130, 95, 120, 70, 120 ]
  },
  "ZRH" => { # Zurich
    destinations: [ "CDG", "LHR", "AMS", "FRA", "MAD", "BCN", "IST", "MUC", "FCO", "CPH", "BRU", "VIE", "GVA", "MXP", "DUS" ],
    durations: [ 90, 110, 85, 60, 140, 120, 180, 55, 95, 120, 80, 80, 45, 60, 75 ]
  },
  "CPH" => { # Copenhagen
    destinations: [ "CDG", "LHR", "AMS", "FRA", "IST", "MUC", "ZRH", "ARN", "BRU", "VIE", "OSL", "WAW", "HEL", "DUS" ],
    durations: [ 120, 120, 90, 90, 180, 90, 120, 70, 90, 100, 70, 75, 90, 75 ]
  },
  "ARN" => { # Stockholm
    destinations: [ "LHR", "AMS", "FRA", "CPH", "BRU", "VIE", "OSL", "HEL", "DUS", "WAW" ],
    durations: [ 150, 135, 120, 70, 135, 140, 60, 55, 120, 90 ]
  },
  "BRU" => { # Brussels
    destinations: [ "CDG", "LHR", "AMS", "FRA", "MAD", "BCN", "IST", "MUC", "FCO", "ZRH", "CPH", "ARN", "VIE", "DUB", "DUS" ],
    durations: [ 60, 70, 40, 70, 150, 135, 195, 90, 130, 80, 90, 135, 105, 90, 45 ]
  },
  "VIE" => { # Vienna
    destinations: [ "CDG", "LHR", "AMS", "FRA", "MAD", "BCN", "IST", "MUC", "FCO", "ZRH", "CPH", "ARN", "BRU", "WAW", "PRG", "BUD" ],
    durations: [ 110, 140, 105, 80, 165, 150, 120, 60, 95, 80, 100, 140, 105, 75, 50, 45 ]
  },
  "DUB" => { # Dublin
    destinations: [ "CDG", "LHR", "AMS", "BRU", "MAN", "EDI" ],
    durations: [ 90, 60, 100, 90, 45, 55 ]
  },
  "OSL" => { # Oslo
    destinations: [ "LHR", "AMS", "FRA", "CPH", "ARN", "HEL" ],
    durations: [ 120, 110, 120, 70, 60, 80 ]
  },
  "WAW" => { # Warsaw
    destinations: [ "CDG", "LHR", "AMS", "FRA", "MUC", "CPH", "ARN", "VIE", "PRG", "BUD" ],
    durations: [ 150, 150, 120, 90, 90, 75, 90, 75, 70, 70 ]
  },
  "PRG" => { # Prague
    destinations: [ "CDG", "LHR", "AMS", "FRA", "MAD", "MUC", "VIE", "WAW", "BUD", "DUS" ],
    durations: [ 110, 135, 90, 60, 180, 60, 50, 70, 65, 75 ]
  },
  "LIS" => { # Lisbon
    destinations: [ "CDG", "LHR", "AMS", "FRA", "MAD", "BCN" ],
    durations: [ 150, 165, 180, 180, 80, 120 ]
  },
  "ATH" => { # Athens
    destinations: [ "CDG", "LHR", "AMS", "FRA", "MAD", "BCN", "IST", "MUC", "FCO" ],
    durations: [ 210, 225, 195, 165, 210, 180, 90, 150, 120 ]
  },
  "HEL" => { # Helsinki
    destinations: [ "CDG", "LHR", "AMS", "FRA", "CPH", "ARN", "OSL", "SVO" ],
    durations: [ 210, 180, 150, 150, 90, 55, 80, 90 ]
  },
  "MXP" => { # Milan
    destinations: [ "CDG", "LHR", "AMS", "FRA", "MAD", "BCN", "MUC", "FCO", "ZRH", "DUS" ],
    durations: [ 90, 105, 100, 90, 135, 105, 75, 70, 60, 90 ]
  },
  "LED" => { # St. Petersburg
    destinations: [ "SVO", "HEL", "ARN", "CPH" ],
    durations: [ 75, 60, 75, 105 ]
  },
  "MAN" => { # Manchester
    destinations: [ "LHR", "AMS", "DUB", "EDI" ],
    durations: [ 60, 75, 45, 65 ]
  },
  "DUS" => { # Düsseldorf
    destinations: [ "CDG", "LHR", "AMS", "FRA", "MAD", "BCN", "MUC", "FCO", "ZRH", "CPH", "BRU", "MXP", "PRG" ],
    durations: [ 90, 90, 60, 45, 170, 150, 70, 120, 75, 75, 45, 90, 75 ]
  },
  "SVO" => { # Moscow
    destinations: [ "CDG", "LHR", "FRA", "IST", "LED", "HEL" ],
    durations: [ 210, 225, 180, 150, 75, 90 ]
  },
  "KRK" => { # Krakow
    destinations: [ "WAW", "VIE", "MUC", "PRG", "BUD" ],
    durations: [ 45, 60, 90, 75, 75 ]
  },
  "GVA" => { # Geneva
    destinations: [ "CDG", "LHR", "FRA", "ZRH", "LYS" ],
    durations: [ 60, 90, 80, 45, 40 ]
  },
  "LYS" => { # Lyon
    destinations: [ "CDG", "GVA", "ZRH", "MXP", "BCN" ],
    durations: [ 60, 40, 55, 65, 90 ]
  },
  "BUD" => { # Budapest
    destinations: [ "CDG", "LHR", "FRA", "IST", "MUC", "VIE", "WAW", "PRG", "KRK" ],
    durations: [ 120, 150, 90, 120, 80, 45, 70, 65, 75 ]
  },
  "EDI" => { # Edinburgh
    destinations: [ "LHR", "DUB", "MAN", "AMS" ],
    durations: [ 60, 55, 65, 90 ]
  }
}

# Create realistic flights
flight_connections.each do |origin, data|
  data[:destinations].each_with_index do |destination, index|
    3.times do |i|
      Flight.create!(
        departure_airport: airport_objects[origin],
        arrival_airport: airport_objects[destination],
        start_datetime: DateTime.new(2025, 5, 30, 0, 0, 0),
        flight_duration: data[:durations][index]
      )
    end
  end
end

# Create specific Madrid-Prague flight
Flight.create!(
  departure_airport: airport_objects["MAD"],
  arrival_airport: airport_objects["PRG"],
  start_datetime: DateTime.new(2025, 5, 30, 0, 0, 0),
  flight_duration: 150
)

# Faker::Time.forward(days: 1, period: :day)
