class Exchange < ApplicationRecord
  validates :company_name, :company_number, :phone_number, presence: true
  validates_uniqueness_of :company_number
  validates :company_number, presence: true, numericality: { only_integer: true }
  validates_length_of :company_number, :is => 8
  has_one :coupon
  validate :company_number_check

  def company_number_check
    result = []
    serial_array = company_number.to_s.split('')
    num_array = [1, 2, 1, 2, 1, 2, 4, 1]
    serial_array.zip(num_array) { |a, b| result << a.to_i * b }
    sum = 0
    result.each { |elm| 
    sum += elm.divmod(10).inject { |s, i| s + i }
    }
    return true if (sum % 10 == 0) or (sum % 9 == 9 and serial[5] == 7)
  end

  

end
