class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?, only: [:edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
    
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
    
    if @event.update(event_params)
      redirect_to @event, notice: "Event mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    
  end

  def event_params
    params.require(:event).permit(:title, :start_date, :duration, :price, :location, :description)
  end

  def is_admin?
    unless @event.admin == current_user
      redirect_back(fallback_location: root_path, alert: "Accès réservé à l'administrateur de l'événement.")
    end
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
