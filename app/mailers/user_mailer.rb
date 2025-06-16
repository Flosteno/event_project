class UserMailer < ApplicationMailer
  default from: ENV["GMAIL_LOGIN"]

  def welcome_email(user)
    @user = user
    @url = 'https://monsite.fr/login'
    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end

  def participation_confirmation(user, event)
    @user = user
    @event = event
    mail(to: @user.email, subject: "Confirmation de participation à l'événement #{@event.title}")
  end

end
