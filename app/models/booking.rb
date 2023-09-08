class Booking < ApplicationRecord
  belongs_to :listing
  belongs_to :guest, class_name: 'User'
  has_one :host, through: :listing

  validates :total_guests, presence: true

  scope :requests_for, ->(user) { joins(:listing).where(listings: { host: user }) }
end
