class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :unavailable_dates

end
