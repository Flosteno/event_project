class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :welcome_send

  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event
  has_many :admin_events, class_name: "Event", foreign_key: "admin_id", dependent: :destroy
  has_one_attached :avatar


  def welcome_send
    puts "Envoie de l'email"
    UserMailer.welcome_email(self).deliver_now
  end

  def attend_event?(event)
    attended_events.exists?(event.id)
  end
  
end
