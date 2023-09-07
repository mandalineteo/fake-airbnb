class Booking < ApplicationRecord
  belongs_to :listing
  belongs_to :guest, class_name: 'User'
end
