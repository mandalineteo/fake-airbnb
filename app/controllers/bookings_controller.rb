class BookingsController < ApplicationController
  def host
    @bookings = Booking.requests_for(current_user)
    @listings = Listing.all
  end

  def stats
    @listings = Listing.all
  end
end
