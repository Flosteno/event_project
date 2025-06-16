class User < ApplicationRecord
  after_create :welcome_send

  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event
  
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
  
end
