class Listing < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :unavailable_dates
  belongs_to :host, class_name: 'User'
  has_many_attached :photos
end
