class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_host, only: %i[new create]

  def index
  end

  def show
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.host = @host
    if @listing.save
      redirect_to new_listing_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_host
    @host = current_user
  end

  def listing_params
    params.require(:listing).permit(:name, :details, :location, :max_guests, :price_per_night)
  end
end
