class BookingsController < ApplicationController

  def host
    @bookings = Booking.requests_for(current_user)
  end
end
