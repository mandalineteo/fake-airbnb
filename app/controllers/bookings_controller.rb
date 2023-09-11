class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :set_listing, only: %i[show]

  def index
  end

  def new
    @listing = Listing.find(params[:listing_id])
    @booking = Booking.new
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @booking = Booking.new(booking_params)
    @booking.guest = current_user
    @booking.listing = @listing
    if @booking.save
      redirect_to bookings_path
    else
      @start_date = booking_params[:start_date]
      @end_date = booking_params[:end_date]
      @members = booking_params[:total_guests]

      @errors = @booking.errors.full_messages

      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_guests, :status)
  end
end
