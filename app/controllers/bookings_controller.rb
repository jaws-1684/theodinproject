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
      redirect_to @booking, status: :see_other, notice: "Booking was successfully created."
    else 
      @flight = @booking.flight
      @num_tickets = @booking.passengers.size
      render 'new', status: :unprocessable_entity, notice: "There was an error creating your booking."
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end


  private

  def booking_params
    params.expect(booking: [:flight_id, { passengers_attributes: [[:name, :email]] }] )
  end
end

