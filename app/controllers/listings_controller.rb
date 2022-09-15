class ListingsController < ApplicationController
  def index
    @listings = Listing.all
    render json: @listings
  end

  def show
    @listing = Listing.find(params[:id])
    render json: @listing
  end

  def create
    @listing = Listing.create(num_rooms: params[:num_rooms])
    render json: @listing
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update(num_rooms: params[:num_rooms])
    render json: "Listing #{@listing.id} has been updated!"
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    render json: "Listing #{@listing.id} has been deleted!"
  end
end
