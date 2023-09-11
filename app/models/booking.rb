class Booking < ApplicationRecord
  belongs_to :listing
  belongs_to :guest, class_name: 'User'
  has_one :host, through: :listing

  validates :total_guests, presence: true

  scope :requests_for, ->(user) { joins(:listing).where(listings: { host: user }) }

  def self.total_earnings(bookings)
    bookings.reduce(0) { |sum, booking| sum + booking.total_price }
  end

  def total_price
    num_of_days = (end_date - start_date).to_i
    price = listing.price_per_night
    price * num_of_days
  end

  def main_image_key
    listing.photos.first.key
  end
end
