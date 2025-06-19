class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = Event.find(params[:event_id])
  end

  def success
    event = Event.find(params[:event_id])
    session_id = params[:session_id]

    # Récupérer la session Stripe
    session = Stripe::Checkout::Session.retrieve(session_id)

    # Vérifier que le paiement est réussi
    if session.payment_status == "paid"
      # Créer l'attendance 
      Attendance.create!(
        user: current_user,
        event: event,
        stripe_customer_id: session.id,
      )
      flash[:notice] = "Votre inscription a bien été enregistrée !"
      redirect_to event_path(event)
    else
      flash[:alert] = "Le paiement n'a pas été validé."
      redirect_to event_path(event)
    end
  end

  def create
    event = Event.find(params[:event_id])

    if event
      # Créer l'attendance 
      Attendance.create!(
        user: current_user,
        event: event,
        stripe_customer_id: "",
      )
      flash[:notice] = "Votre inscription a bien été enregistrée !"
      redirect_to event_path(event)
    else
      flash[:alert] = "L'inscription n'a pas été validé."
      redirect_to event_path(event)
    end
  end


  def index
    @event = Event.find(params[:event_id])

    unless current_user == @event.admin
      redirect_to root_path, alert: "Accès non autorisé."
      return
    end

    @attendances = @event.attendances.includes(:user)
  end  

end
