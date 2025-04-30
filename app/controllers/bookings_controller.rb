class BookingsController < ApplicationController

  def new
    @flight = Flight.find(params[:flight_id])
    @num_tickets = params[:num_tickets].to_i

    @booking = Booking.new(flight: @flight)
    @num_tickets.times {@booking.passengers.build}
  end

  def create
    @booking = Booking.new(booking_params)
    
    
    if @booking.save
      flash[:success] = "Booking was successfully created."
      redirect_to @booking, status: :see_other
    else 
      @flight = @booking.flight
      @num_tickets = @booking.passengers.size
      flash.now[:error] = "There was an error creating your booking."
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end


  private

  def booking_params
    # params.require(:booking).permit(:flight_id, passengers_attributes: [:id, :name, :email])
    params.expect(booking: [flight_id, passengers_attributes: [:name, :email]])
  end
end

