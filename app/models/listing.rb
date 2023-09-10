class Listing < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :unavailable_dates, dependent: :destroy
  belongs_to :host, class_name: 'User'
  has_many_attached :photos, dependent: :destroy
end
