class Listing < ApplicationRecord
  has_many :bookings
  has_many :unavailable_dates
  belongs_to :host, class_name: 'User'
end
