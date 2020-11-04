class Exchange < ApplicationRecord
  validates :company_name, :company_number, :phone_number, presence: true
  validates_uniqueness_of :company_number
  validates :company_number, presence: true, numericality: { only_integer: true }
  validates_length_of :company_number, :is => 8
  has_one :coupon
  validates :company_number_check, presence: true

  def company_number_check
    #參考龍哥的驗證gitHub:https://gist.github.com/kaochenlong/1889703
    at_least_8_digits =  /^\d{8}$/
    return false unless at_least_8_digits.match(company_number.to_s)
    result = []
    serial_array = company_number.to_s.split('')
    num_array = [1, 2, 1, 2, 1, 2, 4, 1]
    serial_array.zip(num_array) { |a, b| result << a.to_i * b }
    sum = 0
    result.each { |elm| 
    sum += elm.divmod(10).inject { |s, i| s + i }
    }
    return true if (sum % 10 == 0) or ((sum + 1) % 10 == 0 and company_number.to_s.split('')[6] == "7")
  end

end
