class FlightsController < ApplicationController
  def index
    @flight_options = Airport.all.map { |airport| airport.airport_code + "\s" + "(#{airport.city})"}
    @flight_dates = Flight.pluck(:start_datetime).map { |d| d.strftime("%d/%m/%Y") }.uniq.sort

    if params[:departure_code] && params[:arrival_code].present?
      @results = db_interogation_results
    end
  end

  private

    def db_interogation_results
      departure_airport = Airport.find_by(airport_code: params[:departure_code][0..2])
      arrival_airport = Airport.find_by(airport_code: params[:arrival_code][0..2])
      flight_date = Date.parse(params[:flight_date])

      flights = Flight.where(
        departure_airport_id: departure_airport.id,
        arrival_airport_id: arrival_airport.id,
        start_datetime: flight_date.all_day
      )
    end
end
