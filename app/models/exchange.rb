class Exchange < ApplicationRecord
    validates :company_name, :company_number, :phone_number, presence: true
    has_one :coupon
end
