class Event < ApplicationRecord
  belongs_to :admin, class_name: "User", foreign_key: "admin_id"
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user
  validates :start_date, presence: true
  validates :duration, presence: true, numericality: {only_integer: true, greater_than: 0,  message: "doit être un nombre entier strictement positif" }
  validate :duration_multiple_of_5
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to:1000 }
  validates :location, presence: true


  private

  def duration_multiple_of_5
    return if duration.nil?
    unless duration % 5 == 0
      errors.add(:duration, "doit être un multiple de 5")
    end
  end
  
end
