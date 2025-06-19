class Event < ApplicationRecord
  belongs_to :admin, class_name: "User", foreign_key: "admin_id"
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user
  validates :start_date, presence: true
  validate :start_date_cannot_be_in_the_past
  validates :duration, presence: true, numericality: {only_integer: true, greater_than: 0,  message: "doit être un nombre entier strictement positif" }
  validate :duration_multiple_of_5
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to:1000 }
  validates :location, presence: true


  def end_date
    return nil if start_date.nil? || duration.nil?
    start_date + duration.minutes
  end

  def is_free?
    price == 0
  end

  private

  def duration_multiple_of_5
    return if duration.nil?
    unless duration % 5 == 0
      errors.add(:duration, "doit être un multiple de 5")
    end
  end

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Time.current
      errors.add(:start_date, "ne peut pas être dans le passé.")
    end
  end

  
end
