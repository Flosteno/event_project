class Attendance < ApplicationRecord
  after_create :participation_confirmation_send

  belongs_to :user
  belongs_to :event

  def participation_confirmation_send
    UserMailer.participation_confirmation(self.user, self.event).deliver_now
  end

end
