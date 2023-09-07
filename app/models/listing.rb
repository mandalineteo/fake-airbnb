class Listing < ApplicationRecord
  belongs_to :host, class_name: 'User'
  has_many_attached :photos
end
