class EventsController < ApplicationController
  
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      flash[:success] = "Event was succesfully created."
      redirect_to @event, status: :see_other
    else 
      flash[:error] = "There was an error creating your event."
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event, status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def event_params
    params.expect(event: [:date, :location, :title, :body])
  end
end
