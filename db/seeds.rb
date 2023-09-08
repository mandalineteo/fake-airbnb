# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

puts "Creating 11 Users"
User.destroy_all
users = []

user1 = User.create!(
  first_name: "test1",
  last_name: "test2",
  email: "test123@gmail.com",
  password: "password"
)

# users << user1

10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password"
  )
  users << user
end

puts "Finished creating 11 users"

# -----------------------------------------
puts "Creating listings"
Listing.destroy_all

# Listing.create!(
#   details: "Beautiful House",
#   location: "Singapore",
#   max_guests: "5",
#   price_per_night: 350.89,
#   host: user1
# )

# TODO: TO ADD IMAGES
puts "creating 5 listings for user 1..."
5.times do
  Listing.create!(
    details: Faker::Restaurant.description,
    name: Faker::Restaurant.name,
    location: Faker::Address.city,
    max_guests: Faker::Number.between(from: 1, to: 10),
    price_per_night: Faker::Number.decimal(l_digits: 2),
    host: user1
  )
end

puts "creating 20 random listings..."
20.times do
  Listing.create!(
    details: Faker::Restaurant.description,
    name: Faker::Restaurant.name,
    location: Faker::Address.city,
    max_guests: Faker::Number.between(from: 1, to: 10),
    price_per_night: Faker::Number.decimal(l_digits: 2),
    host: users.sample
  )
end

puts "Finished creating listings"

# ------------------------------------------

booking_status = ["pending", "confirmed", "declined"]

puts "Creating bookings"
Booking.destroy_all
# users = User.all
listings = Listing.all

puts "creating 5 bookings for user 1..."
# TODO : use Date module for dates
# User.where.not(id: User.first.id)

# Create present bookings
# - Bookings made to user 1
#   - 2 pending
#   - 2 declined
#   - 2 confirmed
# - Bookings made by user 1
#   - 2 pending
#   - 2 declined
#   - 2 confirmed

5.times do
  Booking.create!(
    start_date: Faker::Date.between(from: '2023-06-01', to: '2023-08-31'),
    end_date: Faker::Date.between(from: '2023-09-01', to: '2023-10-31'),
    total_guests: Faker::Number.between(from: 1, to: 10),
    status: booking_status.sample,
    listing: Listing.find_by(host: user1),
    guest: user.sample   #to check tomorrow (08-09-2023) host & guest may be the same person
  )
end

puts "creating 20 random bookings..."
20.times do
  Booking.create!(
    start_date: Faker::Date.between(from: '2023-06-01', to: '2023-08-31'),
    end_date: Faker::Date.between(from: '2023-09-01', to: '2023-10-31'),
    total_guests: Faker::Number.between(from: 1, to: 10),
    status: booking_status.sample,
    listing: listings.sample,
    guest: user.sample   #to check tomorrow (08-09-2023) host & guest may be the same person
  )
end

puts "Finished creating bookings"

# ---------------------------------------------------

puts "Creating unavailable dates"

20.times do
  UnavailableDate.create!(
    start_date: Date.today - 2.months,
    end_date: Date.today + 2.months,
    listing: listing.first(3)
  )
end

puts "Finished creating unavailable dates"
