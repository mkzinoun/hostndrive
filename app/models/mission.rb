class Mission < ApplicationRecord
  MISSION_TYPES = ['first_checkin', 'last_checkout', 'checkout_checkin']
  belongs_to :listing
  validates :mission_type, :date, :price, presence: true
  validates :mission_type, inclusion: { in: MISSION_TYPES }
  validates :price, numericality: { only_integer: true, greater_than: 0 }
end
