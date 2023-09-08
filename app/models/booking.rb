class Booking < ApplicationRecord
  belongs_to :listing
  belongs_to :guest, class_name: 'User'

  validates :total_guests, presence: true

  def main_image_key
    listing.photos.first.key
  end
end
