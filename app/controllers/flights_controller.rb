class FlightsController < ApplicationController
  def index
    @airports = Airport.all.order(:code)
    @passenger_options = [1, 2, 3, 4]
    @available_dates = Flight.select('DISTINCT DATE(start_datetime)').order('DATE(start_datetime)').map do |flight|
      flight.start_datetime.to_date
    end
    @flights = Flight.search(params) if search_params_present?
    @search_performed = search_params_present?

    @num_tickets = params[:num_tickets].to_i if params[:num_tickets].present?
  end

  private

    def search_params_present?
      params[:departure_airport_id].present? || 
      params[:arrival_airport_id].present? || 
      params[:date].present?
    end
end
