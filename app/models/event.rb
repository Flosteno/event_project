class Event < ApplicationRecord
  belongs_to :admin, class_name: "User", foreign_key: "admin_id"
  has_many :attendances
  has_many :attendees, through: :attendances, source: user
  validates :start_date, presence: true
  validates :duration, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to:1000 }
  validates :location, presence: true
end
