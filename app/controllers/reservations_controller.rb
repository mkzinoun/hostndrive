class ReservationsController < ApplicationController
  def create
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.create(listing_id: @listing.id, start_date: params[:start_date], end_date: params[:end_date])
    render json: @reservation
    Mission.create(listing_id: @listing.id, mission_type: 'checkout_checkin', date: @reservation.end_date, price: 10 * @listing.num_rooms) unless Mission.where(mission_type: 'last_checkout').where(date: @reservation.end_date)
  end

  def destroy
    @reservation = Reservation.find(params[:reservation_id])
    @listing = @reservation.listing
    @reservation.destroy
    Mission.where(listing_id: @listing.id).where(date: @reservation.end_date).destroy
    render json: "reservation #{@reservation.id} has been deleted!"
  end
end
