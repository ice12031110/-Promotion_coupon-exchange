class Coupon < ApplicationRecord
  validates_uniqueness_of :serial_number
  validates :serial_number,presence: true
  belongs_to :exchange

  
end
