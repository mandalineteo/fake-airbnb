class Listing < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: true
end
