class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"
  has_many :bookings
  has_many :passengers, through: :bookings

  def flight_date
    start_datetime.strftime('%m/%d/%Y')
  end
  
  def formatted_datetime
    start_datetime.strftime('%b %d, %Y %H:%M')
  end
  
  def duration_in_hours_minutes
    hours = flight_duration / 60
    minutes = flight_duration % 60
    "#{hours}h #{minutes}m"
  end
  
  def self.search(params)
    flights = Flight.all
    
    if params[:departure_airport_id].present?
      flights = flights.where(departure_airport_id: params[:departure_airport_id])
    end
    
    if params[:arrival_airport_id].present?
      flights = flights.where(arrival_airport_id: params[:arrival_airport_id])
    end
    
    if params[:date].present?
      date = Date.parse(params[:date])
      flights = flights.where(start_datetime: date.beginning_of_day..date.end_of_day)
    end
    
    flights
  end
end
