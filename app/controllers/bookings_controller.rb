class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
    @flight = Flight.find(params[:flight_id])
    params[:num_tickets].to_i.times { @booking.passengers.build }
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Flight not found."
    redirect_to flights_path
  end

  def show
    @booking = Booking.find(params[:id])
    @flight = @booking.flight
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Booking not found."
    redirect_to root_path
  end

  def create
    @booking = Booking.new(booking_params)
    
    
    if @booking.save
      flash[:success] = "Booking was successfully created."
      redirect_to @booking, status: :see_other
    else 
      @flight = Flight.find(@booking.flight_id)
      flash.now[:error] = "There was an error creating your booking."
      render 'new', status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Flight not found."
    redirect_to flights_path
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, :num_tickets, passengers_attributes: [:id, :name, :email])
  end
end