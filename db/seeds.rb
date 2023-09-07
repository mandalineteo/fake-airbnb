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

puts "creating 5 listings for user 1..."
5.times do
  Listing.create!(
    details: Faker::Restaurant.description,
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
    location: Faker::Address.city,
    max_guests: Faker::Number.between(from: 1, to: 10),
    price_per_night: Faker::Number.decimal(l_digits: 2),
    host: users.sample
  )
end

puts "Finished creating listings"

# ------------------------------------------
puts "Creating bookings"


puts "Finished creating bookings"
