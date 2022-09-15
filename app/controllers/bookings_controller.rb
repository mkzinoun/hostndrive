class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    render json: @bookings
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @booking = Booking.create(listing_id: @listing.id, start_date: params[:start_date], end_date: params[:end_date])
    render json: @booking
    Mission.create(listing_id: @listing.id, mission_type: 'first_checkin', date: @booking.start_date, price: 10 * @listing.num_rooms)
    Mission.create(listing_id: @listing.id, mission_type: 'last_checkout', date: @booking.end_date, price: 5 * @listing.num_rooms)
  end

  def destroy
    @booking = Booking.find(params[:booking_id])
    @listing = @booking.listing
    @booking.destroy
    Mission.where(listing_id: @listing.id).where(date: @booking.start_date).destroy
    Mission.where(listing_id: @listing.id).where(date: @booking.end_date).destroy
    render json: "booking #{@booking.id} has been deleted!"
  end
end
