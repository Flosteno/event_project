class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.admin = current_user

    if @event.save
      redirect_to @event, notice: "Événement créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def event_params
    params.require(:event).permit(:title, :start_date, :duration, :price, :location, :description)
  end

  def correct_user
    admin = @event.admin
    unless admin == current_user
      redirect_back fallback_location: root_path, alert: "Accès non autorisé"
    end
  end
end
