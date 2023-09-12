require 'faker'
require "open-uri"
require 'date'

require_relative 'singapore_addresses'

seed_users = true
seed_listings = true
seed_bookings = true
seed_unavailable_dates = true

# ------------------------------------------

puts "\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
puts "   Take note: this file could take up "
puts "   to 5 mins to complete. Blame Ashley."
puts "   😈😈😈😈😈😈😈😈😈😈😈😈😈😈"
puts "   ☠️ You have been warned!! ☠️"
puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n"


if seed_users
  puts "===== Creating Users =====\n"
  User.destroy_all
  users = []

  user1 = User.create!(
    first_name: "Test1",
    last_name: "Test2",
    email: "test123@gmail.com",
    password: "password"
  )
  puts "--- created #{user1.first_name}."

  # users << user1

  10.times do
    user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: "password"
    )
    users << user
    puts "--- created #{user.first_name}."
  end
end


# -----------------------------------------

if seed_listings
  puts "\n\n===== Creating listings =====\n"
  Listing.destroy_all

  puts "creating 5 listings for user 1..."
  5.times do
    puts '--- creating new listing...'
    listing = Listing.create!(
      name: Faker::Travel::TrainStation.name(region: 'united_states', type: 'metro'),
      details: "Welcome to #{Faker::Travel::TrainStation.name(region: 'united_states', type: 'metro')}! We have a big #{Faker::House.room} and we are sure that you will enjoy your stay with us!",
      location: SINGAPORE_ADDRESSES.pop,
      max_guests: Faker::Number.between(from: 1, to: 10),
      price_per_night: Faker::Number.decimal(l_digits: 2),
      host: user1
    )

    image_source = "https://source.unsplash.com/featured/600x600/?interior%20design&id=#{rand(100000)}"
    puts '    -- attaching images...'
    5.times do
      image_url = URI.open(image_source)
      listing.photos.attach(io: image_url, filename: "#{listing.name.split.join('-')}.png", content_type: "image/png")
    end

    puts "    -- created #{listing.name}."

  end

  puts "\ncreating 20 random listings..."
  20.times do
    puts '--- creating new listing...'
    listing = Listing.create!(
      name: Faker::Travel::TrainStation.name(region: 'united_kingdom', type: 'metro'),
      details: "Welcome to #{Faker::Travel::TrainStation.name(region: 'united_kingdom', type: 'metro')}! We have a big #{Faker::House.room} and we are sure that you will enjoy your stay with us!",
      location: SINGAPORE_ADDRESSES.pop,
      max_guests: Faker::Number.between(from: 1, to: 10),
      price_per_night: Faker::Number.decimal(l_digits: 2),
      host: users.sample
    )

    image_source = "https://source.unsplash.com/featured/600x600/?interior%20design&id=#{rand(100000)}"
    puts '    -- attaching image...'
    5.times do
      image_url = URI.open(image_source)
      listing.photos.attach(io: image_url, filename: "#{listing.name.split.join('-')}.png", content_type: "image/png")
    end

    puts "    -- created #{listing.name}."

  end
end


# ------------------------------------------

if seed_bookings
  puts "\n\n===== Create Bookings =====\n"

  puts 'clearing old data...'
  Booking.destroy_all

  user1 = User.first
  users = User.where.not(id: user1.id)
  user1_listings = Listing.where(host: user1)
  other_listings = Listing.where.not(host: user1)

  start = Date.today

  puts "\nCreating bookings made to user1's listings..."
  puts "  -- Creating present pending bookings"
  2.times do
    start_date = start + rand(10).days
    Booking.create!(
      guest: users.sample,
      status: 'pending',
      listing: user1_listings.sample,
      start_date: start_date,
      end_date: start_date + rand(7).days,
      total_guests: rand(1..5)
    )
    puts "     -- Created!"
  end

  puts "  -- Creating present declined bookings"
  2.times do
    start_date = start + rand(10).days
    Booking.create!(
      guest: users.sample,
      status: 'declined',
      listing: user1_listings.sample,
      start_date: start_date,
      end_date: start_date + rand(7).days,
      total_guests: rand(1..5)
    )
    puts "     -- Created!"
  end

  puts "  -- Creating present confirmed bookings"
  2.times do
    start_date = start + rand(10).days
    Booking.create!(
      guest: users.sample,
      status: 'confirmed',
      listing: user1_listings.sample,
      start_date: start_date,
      end_date: start_date + rand(7).days,
      total_guests: rand(1..5)
    )
    puts "     -- Created!"
  end

  puts "\nCreating bookings made by User1"

  puts "  -- Creating present pending bookings"
  2.times do
    start_date = start + rand(10).days
    Booking.create!(
      guest: user1,
      status: 'pending',
      listing: other_listings.sample,
      start_date: start_date,
      end_date: start_date + rand(7).days,
      total_guests: rand(1..5)
    )
    puts "     -- Created!"
  end

  puts "  -- Creating present declined bookings"
  2.times do
    start_date = start + rand(10).days
    Booking.create!(
      guest: user1,
      status: 'declined',
      listing: other_listings.sample,
      start_date: start_date,
      end_date: start_date + rand(7).days,
      total_guests: rand(1..5)
    )
    puts "     -- Created!"
  end

  puts "  -- Creating present confirmed bookings"
  2.times do
    start_date = start + rand(10).days
    Booking.create!(
      guest: user1,
      status: 'confirmed',
      listing: other_listings.sample,
      start_date: start_date,
      end_date: start_date + rand(7).days,
      total_guests: rand(1..5)
    )
    puts "     -- Created!"
  end

  # end of bookings
end


if seed_unavailable_dates
  puts "\n\n===== Create Unavailable Dates =====\n"

  puts 'Clearing old data...'
  UnavailableDate.destroy_all

  listings = Listing.first(2)

  listings.each do |listing|
    puts "  Creating unavailable dates for #{listing.name}..."

    2.times do
      start_date = listing.unavailable_dates.last ? listing.unavailable_dates.last.end_date : Date.today
      start_date += 2.weeks

      UnavailableDate.create!(
        listing: listing,
        start_date: start_date,
        end_date: start_date + rand(7..14).days
      )
    end
  end
end

# 5.times do
#   Booking.create!(
#     start_date: Faker::Date.between(from: '2023-06-01', to: '2023-08-31'),
#     end_date: Faker::Date.between(from: '2023-09-01', to: '2023-10-31'),
#     total_guests: Faker::Number.between(from: 1, to: 10),
#     status: booking_status.sample,
#     listing: Listing.find_by(host: user1),
#     guest: users.sample   #to check tomorrow (08-09-2023) host & guest may be the same person
#   )
# end


# # ---------------------------------------------------

# puts "Creating unavailable dates"

# 20.times do
#   UnavailableDate.create!(
#     start_date: Date.today - 2.months,
#     end_date: Date.today + 2.months,
#     listing: listing.first(3)
#   )
# end

# puts "Finished creating unavailable dates"


puts "Done! 🚀🚀🚀"
