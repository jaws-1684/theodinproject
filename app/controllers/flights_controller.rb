class FlightsController < ApplicationController
  def index
    @flight_options = Airport.all.map { |airport| [ airport.airport_code ] }
    @flight_dates = Flight.pluck(:start_datetime).map { |d| d.strftime("%d/%m/%Y").to_date }.uniq.sort
  end

  def new
    @flight = Flight.new
  end
end
