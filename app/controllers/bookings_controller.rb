class BookingsController < ApplicationController

  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def confirm
    @booking = Booking.find(params[:id])

    if @booking.listing.host != current_user
      render json: { success: false }
    else
      @booking.status = "confirmed"
      @booking.save!

      render json: { success: true }
    end
  end

  def decline
    @booking = Booking.find(params[:id])

    if @booking.listing.host != current_user
      render json: { success: false }
    else
      @booking.status = "declined"
      @booking.save!

      render json: { success: true }
    end
  end

  def host
    @bookings = Booking.requests_for(current_user)
    @listings = Listing.all

    if params[:filter]
      if params[:filter] == "pending"
        @bookings = @bookings.where(status: "pending")
      end

      if params[:filter] == "upcoming"
        @bookings = @bookings.where("start_date > ?", Date.today).where(status: "confirmed")
      end
    end
  end

  def stats
    @bookings = Booking.requests_for(current_user).where(status: "confirmed")
    @listings = Listing.all

    if params[:filter] == "current_year"
      puts "filter by current year"
      @bookings = @bookings.where("start_date > ?", Date.today.beginning_of_year)
    elsif params[:filter] == "current_month"
      puts "filter by current month"
      @bookings = @bookings.where("start_date > ?", Date.today.beginning_of_month)
    end
  end

  private

  def booking_status_params
    params.require(:booking).permit(:status)
  end

end
