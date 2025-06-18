class CheckoutController < ApplicationController

  def create

    @event = Event.find(params[:event_id])

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          product_data: {
            name: @event.title,
          },
          unit_amount: @event.price*100,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: "#{request.base_url}/attendances/success?event_id=#{@event.id}&session_id={CHECKOUT_SESSION_ID}",
      cancel_url: root_url + "?canceled=true",
    )

    redirect_to session.url, allow_other_host: true
  end

end
