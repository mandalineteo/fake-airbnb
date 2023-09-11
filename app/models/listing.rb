class Listing < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :unavailable_dates, dependent: :destroy
  belongs_to :host, class_name: 'User'

  has_many_attached :photos

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
