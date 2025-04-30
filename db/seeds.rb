Passenger.delete_all
Booking.delete_all
Flight.delete_all
Airport.delete_all

airports = [
  { code: 'CDG', name: 'Paris' },
  { code: 'LHR', name: 'London' },
  { code: 'AMS', name: 'Amsterdam' },
  { code: 'FRA', name: 'Frankfurt' },
  { code: 'MAD', name: 'Madrid' },
  { code: 'BCN', name: 'Barcelona' },
  { code: 'IST', name: 'Istanbul' },
  { code: 'MUC', name: 'Munich' },
  { code: 'FCO', name: 'Rome' },
  { code: 'ZRH', name: 'Zurich' },
  { code: 'CPH', name: 'Copenhagen' },
  { code: 'ARN', name: 'Stockholm' },
  { code: 'BRU', name: 'Brussels' },
  { code: 'VIE', name: 'Vienna' },
  { code: 'DUB', name: 'Dublin' },
  { code: 'OSL', name: 'Oslo' },
  { code: 'WAW', name: 'Warsaw' },
  { code: 'PRG', name: 'Prague' },
  { code: 'LIS', name: 'Lisbon' },
  { code: 'ATH', name: 'Athens' },
  { code: 'HEL', name: 'Helsinki' },
  { code: 'MXP', name: 'Milan' },
  { code: 'LED', name: 'St. Petersburg' },
  { code: 'MAN', name: 'Manchester' },
  { code: 'DUS', name: 'Düsseldorf' },
  { code: 'SVO', name: 'Moscow' },
  { code: 'KRK', name: 'Krakow' },
  { code: 'GVA', name: 'Geneva' },
  { code: 'LYS', name: 'Lyon' },
  { code: 'BUD', name: 'Budapest' },
  { code: 'EDI', name: 'Edinburgh' },
  { code: 'HIL', name: 'HILIUTI' }
]

airports.each do |airport_data|
  Airport.create!(airport_data)
end

puts "Created #{Airport.count} airports"

airports = Airport.all
start_date = Date.today
end_date = start_date + 30.days
durations = {
  'LHR-CDG' => 75, 'CDG-LHR' => 80,
  'AMS-FRA' => 60, 'FRA-AMS' => 65,
  'MAD-BCN' => 85, 'BCN-MAD' => 90,
  'IST-MUC' => 150, 'MUC-IST' => 155,
  'FCO-ZRH' => 95, 'ZRH-FCO' => 100,
  'CPH-ARN' => 70, 'ARN-CPH' => 75,
  'VIE-DUB' => 160, 'DUB-VIE' => 165,
  'PRG-WAW' => 90, 'WAW-PRG' => 95,
  'LIS-ATH' => 215, 'ATH-LIS' => 220,
  'HEL-MXP' => 185, 'MXP-HEL' => 190,
  'HIL-CDG'=> 240, 'CDG-HIL' => 240
}


(start_date..end_date).each do |date|
  airports.each do |departure_airport|
    airports.each do |arrival_airport|
      next if departure_airport == arrival_airport

      pair_key = "#{departure_airport.code}-#{arrival_airport.code}"
      next unless durations[pair_key]
      

      rand(2..3).times do
        hour = rand(6..22)
        minute = [0, 30].sample
        
        Flight.create!(
          departure_airport: departure_airport,
          arrival_airport: arrival_airport,
          start_datetime: DateTime.new(date.year, date.month, date.day, hour, minute, 0),
          flight_duration: durations[pair_key]
        )
      end
    end
  end
end

puts "Created #{Flight.count} flights"
