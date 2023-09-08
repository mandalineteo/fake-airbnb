class Booking < ApplicationRecord
  belongs_to :listing
  belongs_to :guest, class_name: 'User'

  validates :total_guests, presence: true
end
