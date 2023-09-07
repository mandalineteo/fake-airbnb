class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
  end

  def show
  end

  def new
    @listing = Listing.new
  end

  def create
  end
end
