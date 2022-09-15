class Reservation < ApplicationRecord
  belongs_to :listing
  validates :start_date, :end_date, presence: true
  validates :end_date, comparison: { greater_than: :start_date }
  after_create :create_missions
  after_destroy :destroy_missions

  private

  def create_missions
    Mission.create(listing_id: self.listing_id, mission_type: 'checkout_checkin', date: end_date, price: 10 * listing.num_rooms) if Mission.where(mission_type: 'last_checkout').where(date: end_date) == []
  end

  def destroy_missions
    Mission.where(listing_id: self.listing_id).where(date: end_date).destroy
  end
end
